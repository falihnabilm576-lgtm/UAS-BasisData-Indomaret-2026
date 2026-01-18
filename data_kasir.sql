CREATE DATABASE db_indomaret;
USE db_indomaret;

-- =============================================================
-- BAGIAN 2: IMPLEMENTASI DDL (MEMBUAT TABEL)
-- =============================================================

-- 1. Tabel Pelanggan
CREATE TABLE Pelanggan (
    Id_Pelanggan CHAR(5) PRIMARY KEY,
    Nama_Pelanggan VARCHAR(50),
    No_Telepon VARCHAR(15),
    Tipe_Pelanggan VARCHAR(20)
);

-- 2. Tabel Kasir
CREATE TABLE Kasir (
    Id_Kasir CHAR(5) PRIMARY KEY,
    Nama_Kasir VARCHAR(50),
    No_Telepon VARCHAR(15)
);

-- 3. Tabel Barang
CREATE TABLE Barang (
    Id_Barang CHAR(5) PRIMARY KEY,
    Nama_Barang VARCHAR(100),
    Kategori VARCHAR(30),
    Harga_Jual INT,
    Stok INT
);

-- 4. Tabel Transaksi
CREATE TABLE Transaksi (
    No_Nota CHAR(10) PRIMARY KEY,
    Waktu DATETIME,
    Total_Bayar INT,
    Metode_Bayar VARCHAR(20),
    Id_Pelanggan CHAR(5),
    Id_Kasir CHAR(5),
    FOREIGN KEY (Id_Pelanggan) REFERENCES Pelanggan(Id_Pelanggan),
    FOREIGN KEY (Id_Kasir) REFERENCES Kasir(Id_Kasir)
);

-- 5. Tabel Detail Transaksi
CREATE TABLE Detail_Transaksi (
    No_Nota CHAR(10),
    Id_Barang CHAR(5),
    Jumlah INT,
    Subtotal INT,
    PRIMARY KEY (No_Nota, Id_Barang),
    FOREIGN KEY (No_Nota) REFERENCES Transaksi(No_Nota),
    FOREIGN KEY (Id_Barang) REFERENCES Barang(Id_Barang)
);

-- =============================================================
-- BAGIAN 3: IMPLEMENTASI DML (PENGISIAN DATA AWAL)
-- =============================================================

-- Isi Data Pelanggan (PENTING: Diisi dulu sebelum Transaksi)
INSERT INTO Pelanggan VALUES ('P01', 'Budi Santoso', '08111222333', 'Member');
INSERT INTO Pelanggan VALUES ('P02', 'Siti Aminah', '08555666777', 'Non-Member');

-- Isi Data Kasir
INSERT INTO Kasir VALUES ('K01', 'Diva Anggara', '08123456789');
INSERT INTO Kasir VALUES ('K02', 'Falih Nabil', '08198765432');

-- Isi Data Barang
INSERT INTO Barang VALUES ('B001', 'Indomie Goreng', 'Makanan', 3000, 100);
INSERT INTO Barang VALUES ('B002', 'Aqua 600ml', 'Minuman', 3500, 50);
INSERT INTO Barang VALUES ('B003', 'Teh Pucuk', 'Minuman', 4000, 70);
INSERT INTO Barang VALUES ('B004', 'Roti Tawar', 'Makanan', 12000, 20);
INSERT INTO Barang VALUES ('B005', 'Susu UHT', 'Minuman', 6000, 40);

-- =============================================================
-- BAGIAN 4: SKENARIO TRANSAKSI & TCL
-- =============================================================

-- Skenario 1: Transaksi Manual dengan COMMIT (Syarat TCL)
START TRANSACTION;
    -- Header Transaksi
    INSERT INTO Transaksi VALUES ('TRX001', '2025-11-14 10:00:00', 6000, 'Tunai', NULL, 'K01');
    -- Detail Transaksi
    INSERT INTO Detail_Transaksi VALUES ('TRX001', 'B001', 2, 6000);
    -- Update Stok Manual (Sebelum ada Trigger)
    UPDATE Barang SET Stok = Stok - 2 WHERE Id_Barang = 'B001';
COMMIT;

-- Skenario 2: Transaksi Besar (Untuk Data Dummy Laporan)
INSERT INTO Transaksi VALUES ('TRX-BIG', '2025-01-17 14:00:00', 180000, 'Tunai', NULL, 'K01');
INSERT INTO Detail_Transaksi VALUES ('TRX-BIG', 'B001', 60, 180000);

-- Skenario 3: Transaksi Pelanggan Member (Data Awal TRX002)
INSERT INTO Transaksi VALUES ('TRX002', '2025-01-17 10:30:00', 54000, 'QRIS', 'P01', 'K02');
INSERT INTO Detail_Transaksi VALUES ('TRX002', 'B004', 2, 24000); 
-- (Catatan: TRX002 totalnya 54rb, rinciannya 24rb Roti + 30rb Susu yg akan diinput nanti saat tes Trigger)

-- =============================================================
-- BAGIAN 5: QUERY LAPORAN (UNTUK SCREENSHOT)
-- =============================================================

-- 5.1 Query JOIN (Struk Belanja)
SELECT t.No_Nota, t.Waktu, b.Nama_Barang, d.Jumlah, d.Subtotal
FROM Transaksi t
JOIN Detail_Transaksi d ON t.No_Nota = d.No_Nota
JOIN Barang b ON d.Id_Barang = b.Id_Barang
WHERE t.No_Nota = 'TRX001';

-- 5.2 Query GROUP BY (Laporan Omset Kasir)
SELECT k.Nama_Kasir, COUNT(t.No_Nota) AS Jumlah_Transaksi, SUM(t.Total_Bayar) AS Total_Pendapatan
FROM Kasir k
JOIN Transaksi t ON k.Id_Kasir = t.Id_Kasir
GROUP BY k.Nama_Kasir;

-- 5.3 Query HAVING (Barang Terlaris > 50)
SELECT b.Nama_Barang, SUM(d.Jumlah) AS Total_Terjual
FROM Barang b
JOIN Detail_Transaksi d ON b.Id_Barang = d.Id_Barang
GROUP BY b.Nama_Barang
HAVING SUM(d.Jumlah) > 50;

-- 5.4 Subquery (Mencari Barang di atas Harga Rata-rata)
SELECT Nama_Barang, Harga_Jual 
FROM Barang 
WHERE Harga_Jual > (SELECT AVG(Harga_Jual) FROM Barang);

-- 5.5 VIEW (Laporan Virtual)
CREATE OR REPLACE VIEW V_Laporan_Harian AS
SELECT t.No_Nota, t.Waktu, p.Nama_Pelanggan, t.Total_Bayar, t.Metode_Bayar
FROM Transaksi t
LEFT JOIN Pelanggan p ON t.Id_Pelanggan = p.Id_Pelanggan;

-- Menampilkan View
SELECT * FROM V_Laporan_Harian;

-- =============================================================
-- BAGIAN 6: FITUR LANJUTAN (TRIGGER) & PENGUJIAN
-- =============================================================

-- 6.1 Membuat Trigger Otomatis Potong Stok
DELIMITER $$
CREATE TRIGGER Update_Stok_Otomatis
AFTER INSERT ON Detail_Transaksi
FOR EACH ROW
BEGIN
	UPDATE Barang 
	SET Stok = Stok - NEW.Jumlah
	WHERE Id_Barang = NEW.Id_Barang;
END $$
DELIMITER ;

-- 6.2 PEMBUKTIAN TRIGGER (Wajib Screenshot Step by Step)

-- Step A: Cek Stok Awal Susu UHT (B005) - Harusnya 40
SELECT Id_Barang, Nama_Barang, Stok FROM Barang WHERE Id_Barang = 'B005';

-- Step B: Tambah Item Susu ke TRX002 (Beli 5 pcs)
-- Saat script ini jalan, Trigger akan aktif otomatis
INSERT INTO Detail_Transaksi VALUES ('TRX002', 'B005', 5, 30000);

-- Step C: Cek Stok Akhir Susu UHT (B005) - Harusnya jadi 35
SELECT Id_Barang, Nama_Barang, Stok FROM Barang WHERE Id_Barang = 'B005';
