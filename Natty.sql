Nama: Natty Maria Sasherlina
Nisn: 2023.6898

-- Membuat database
CREATE DATABASE IF NOT EXISTS remedial_basis_data;
USE remedial_basis_data;

-- Membuat tabel program studi
CREATE TABLE IF NOT EXISTS tbl_prodi (
    kode_prodi VARCHAR(3) PRIMARY KEY,
    nama_prodi VARCHAR(50)
);

-- Membuat tabel mahasiswa
CREATE TABLE IF NOT EXISTS tbl_mhs (
    nim VARCHAR(8) PRIMARY KEY,
    nama_mhs VARCHAR(50),
    alamat VARCHAR(50),
    umur INT,
    tahun_lulus INT,
    kode_prodi VARCHAR(3),
    FOREIGN KEY (kode_prodi) REFERENCES tbl_prodi(kode_prodi)
);

-- Memasukkan data program studi
INSERT INTO tbl_prodi (kode_prodi, nama_prodi) VALUES
('A01', 'Sistem Komputer'),
('A02', 'Sistem Informasi'),
('A03', 'Teknik Informatika');

-- Memasukkan data mahasiswa
INSERT INTO tbl_mhs (nim, nama_mhs, alamat, umur, tahun_lulus, kode_prodi) VALUES
('04102001', 'Nur Qomari', 'Surabaya', 25, 2009, 'A01'),
('04102002', 'Akham Ahdan', 'Surabaya', 23, 2007, 'A01'),
('04102003', 'Junior', 'Sidoarjo', 22, 2007, 'A01'),
('04202001', 'Eko Prasetyo', 'Sidoarjo', 20, 2006, 'A02'),
('04202002', 'Hadi Irawan', 'Gresik', 26, 2009, 'A02'),
('04202003', 'Badruzzaman', 'Surabaya', 27, 2009, 'A02'),
('04202004', 'Budi Irawan', 'Surabaya', 23, 2007, 'A02');


-- JAWABAN SOAL 1-10


-- 1. Tampilkan Data Mahasiswa yang memiliki umur 25 tahun kebawah
SELECT * FROM tbl_mhs WHERE umur <= 25;

-- 2. Tampilkan Total Mahasiswa yang lulus pada tahun 2009
SELECT COUNT(*) AS total_mhs_2009 
FROM tbl_mhs 
WHERE tahun_lulus = 2009;

-- 3. Tampilkan Data Program Studi yang Jumlah Mahasiswanya paling sedikit (MIN & SUB QUERY)
SELECT p.kode_prodi, p.nama_prodi, COUNT(m.nim) AS jumlah_mahasiswa
FROM tbl_prodi p
JOIN tbl_mhs m ON p.kode_prodi = m.kode_prodi
GROUP BY p.kode_prodi, p.nama_prodi
HAVING COUNT(m.nim) = (
    SELECT MIN(jumlah) 
    FROM (
        SELECT COUNT(nim) AS jumlah 
        FROM tbl_mhs 
        GROUP BY kode_prodi
    ) AS counts
);

-- 4. Tampilkan Data Program Studi yang Jumlah Mahasiswanya paling banyak (MAX & SUB QUERY)
SELECT p.kode_prodi, p.nama_prodi, COUNT(m.nim) AS jumlah_mahasiswa
FROM tbl_prodi p
JOIN tbl_mhs m ON p.kode_prodi = m.kode_prodi
GROUP BY p.kode_prodi, p.nama_prodi
HAVING COUNT(m.nim) = (
    SELECT MAX(jumlah) 
    FROM (
        SELECT COUNT(nim) AS jumlah 
        FROM tbl_mhs 
        GROUP BY kode_prodi
    ) AS counts
);

-- 5. Tampilkan Data Mahasiswa yang Memiliki keyword "Irawan"
SELECT * FROM tbl_mhs WHERE nama_mhs LIKE '%Irawan%';

-- 6. Tampilkan Jumlah Data Mahasiswa Berdasarkan Alamat (GROUP)
SELECT alamat, COUNT(*) AS jumlah_mahasiswa
FROM tbl_mhs
GROUP BY alamat;

-- 7. Masukkan 1 record baru pada table Mahasiswa
INSERT INTO tbl_mhs (nim, nama_mhs, alamat, umur, tahun_lulus, kode_prodi)
VALUES ('04302001', 'Nama Baru', 'Malang', 24, 2020, 'A03');

-- 8. Ganti Nama Mahasiswa yang baru Anda masukkan tersebut menjadi "Gunawan Susilo"
UPDATE tbl_mhs
SET nama_mhs = 'Gunawan Susilo'
WHERE nim = '04302001';

-- 9. Hapus Data yang baru Anda masukkan tersebut
DELETE FROM tbl_mhs WHERE nim = '04302001';

-- 10. Tampilkan Nama Mahasiswa dan Nama Program Studi dengan Penggabungan Dua Tabel (JOIN)
SELECT m.nim, m.nama_mhs, p.nama_prodi
FROM tbl_mhs m
JOIN tbl_prodi p ON m.kode_prodi = p.kode_prodi;
