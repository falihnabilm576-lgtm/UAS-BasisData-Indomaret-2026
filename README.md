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

## RELASI ANTAR TABEL
<img width="955" height="548" alt="image" src="https://github.com/user-attachments/assets/02b373b0-8dc0-49e3-a836-c4eb273ecaf3" />

---

## Query Join (Cetak Struk Belanja) 
<img width="1044" height="246" alt="image" src="https://github.com/user-attachments/assets/ced2f249-59cb-40aa-8f92-a1cef91e2b5d" />

---

## Query Aggregation & Group By (Laporan Omset Kasir) 
<img width="1041" height="246" alt="image" src="https://github.com/user-attachments/assets/a20de54e-e689-4173-9272-b9ce700ade25" />

---

## Query Having (Analisis Barang Terlaris) 
<img width="1038" height="246" alt="image" src="https://github.com/user-attachments/assets/897304c9-d8d3-4db1-91e6-007715ac290c" />

---

## SQL Subquery
<img width="1033" height="247" alt="image" src="https://github.com/user-attachments/assets/09ef0501-3b9c-4fbd-9870-3a730d0dd15d" />

---

## SQL View
<img width="1033" height="247" alt="image" src="https://github.com/user-attachments/assets/2f042825-5dd4-44bd-8337-f36dbeb9d899" />

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

2. Melihat Laporan (View)
SELECT * FROM V_Laporan_Harian;

3. Mencetak Struk
Menampilkan detail belanja lengkap dengan nama barang.
-- Jalankan query JOIN yang ada di file SQL bagian "Query Laporan"

2.3.3 RELASI ANTAR TABEL
<img width="955" height="548" alt="image" src="https://github.com/user-attachments/assets/02b373b0-8dc0-49e3-a836-c4eb273ecaf3" />

