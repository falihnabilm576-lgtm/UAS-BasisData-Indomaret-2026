# 🛒 Sistem Basis Data Transaksi Minimarket (Studi Kasus: Indomaret)

**Final Project - Mata Kuliah Pemrograman Basis Data**
**Universitas Duta Bangsa Surakarta**

Repository ini berisi rancangan dan implementasi sistem basis data untuk menangani transaksi penjualan, pengelolaan stok, dan pelaporan kasir pada minimarket.

---

## 👥 Anggota Kelompok
| NIM | Nama Mahasiswa | Peran |
| :--- | :--- | :--- |
| **240103159** | **Diva Anggara** | Database Designer & Implementer |
| **240103161** | **Falih Nabil Malik** | Data Analyst & Documentation |

---

## 🛠️ Tools yang Digunakan
Proyek ini dikembangkan menggunakan perangkat lunak berikut:
1.  **MySQL Server 8.0** - Sistem Manajemen Basis Data (DBMS).
2.  **MySQL Workbench** - Interface (GUI) untuk eksekusi query dan perancangan ERD.
3.  **Microsoft Word** - Penyusunan laporan dokumentasi.
4.  **Draw.io / Workbench Designer** - Pembuatan Entity Relationship Diagram (ERD).

---

## ⚙️ Langkah Instalasi (Setup Database)
Ikuti langkah berikut untuk memasang database ini di komputer Anda:

1.  **Clone atau Download** repository ini.
    * Klik tombol hijau `Code` -> `Download ZIP`, lalu ekstrak filenya.
2.  Buka aplikasi **MySQL Workbench**.
3.  Login ke koneksi Local Instance Anda.
4.  Buka file SQL:
    * Klik menu `File` -> `Open SQL Script`.
    * Pilih file bernama **`data_kasir.sql`** (atau nama file sql yang Anda upload).
5.  **Eksekusi Script:**
    * Klik tombol **Petir** ⚡ (Execute) di toolbar atas.
    * Pastikan output di bagian bawah menunjukkan pesan hijau (Success).

---

## 🚀 Cara Menjalankan Program
Setelah database terinstal, Anda dapat menjalankan fitur-fitur berikut melalui Query Editor:

### 1. Simulasi Transaksi
Sistem akan otomatis memotong stok barang saat data masuk ke tabel rinci transaksi.
```sql
-- Contoh Input Transaksi
INSERT INTO Transaksi VALUES ('TRX-005', NOW(), 5000, 'Tunai', 'P01', 'K01');
INSERT INTO Detail_Transaksi VALUES ('TRX-005', 'B001', 2, 5000);
-- Cek Stok Barang B001, otomatis berkurang 2 unit.
