<div align="center">

# ⚡ thema-termuxx ASCII: Cybersmith
*Konfigurasi Zsh & Header Cyberpunk Kustom untuk Termux Android yang Ringan, Stabil, dan Presisi.*

</div>

---

## 1. 🚪 Pintu Gerbang Informasi

Selamat datang di repositori **`thema-termuxx`**! Project ini lahir dari eksperimen untuk menghadirkan antarmuka terminal Android (*Termux*) yang estetis dengan skema warna *Neon Cyberpunk*, namun tetap mengedepankan efisiensi kerja, keterbacaan data sistem *real-time*, serta stabilitas navigasi harian.

### Spesifikasi Utama:
* **Shell Framework:** Zsh + Oh My Zsh
* **Tema Visual:** Cybersmith Cyberfunk (Cyan `#05d9e8`, Magenta `#ff2a6d`, Cyber Gold `#ffb000`)
* **Sasaran Perangkat:** Termux di Android (Optimal pada mode Portrait & Landscape)

---

## 2. 🚀 Panduan Instalasi & Konfigurasi

Anda dapat memasang seluruh konfigurasi ini secara instan menggunakan **metode otomatis satu baris**, atau melalui metode manual.

### Metode Otomatis (Direkomendasikan - 1 Baris Perintah)
Cukup salin dan jalankan perintah berikut di terminal Termux Anda:

```bash
bash -c "$(curl -fsSL [https://raw.githubusercontent.com/ar-abdulazis/thema-termuxx/main/install.sh](https://raw.githubusercontent.com/ar-abdulazis/thema-termuxx/main/install.sh))"
```
*Skrip di atas akan secara otomatis memperbarui sistem, memasang dependensi (`git`, `curl`, `zsh`, `python`, `tar`), mengonfigurasi Oh My Zsh dan plugin, mencadangkan file lama, hingga mengekstrak tema Cybersmith.*



### Metode Manual (Opsional)

1. Perbarui sistem & instal paket pendukung:
```bash
pkg update && pkg upgrade -y && pkg install git curl zsh nano python tar -y

```


2. Beri izin akses penyimpanan:
```bash
termux-setup-storage

```


3. Unduh repositori dan ekstrak arsip konfigurasi ke direktori utama (`~/`):
```bash
git clone [https://github.com/ar-abdulazis/thema-termuxx.git](https://github.com/ar-abdulazis/thema-termuxx.git) ~/thema-termuxx
tar -xzf ~/thema-termuxx/*.tar.gz -C ~
termux-reload-settings && exec zsh

```



---

## 3. ⚡ Penjelasan Fitur & Pengoperasian

* **Neural Terminal Header v2.6:** Banner ASCII kustom dengan panel statistik *real-time* (Storage `/data`, Waktu, Tanggal, Versi Python, dan Arsitektur CPU) yang dikunci menggunakan format presisi agar bingkai kanan (`║`) tetap lurus.
* **Anti-Clear Header:** Fungsi *override* pada perintah `clear` dan pintasan `Ctrl + L` memastikan layar kerja bawah bersih tanpa menghapus banner di bagian atas.
* **Custom Dual-Line Prompt:** Desain prompt dua baris neon cyan-magenta lengkap dengan integrasi status Git (`vcs_info`) secara otomatis.

### Ringkasan Shortcut (Aliases)

| Alias | Perintah Asli | Fungsi Singkat |
| --- | --- | --- |
| `rc` / `zshrc` | `nano ~/.zshrc` | Edit file konfigurasi Zsh |
| `rl` / `reload` | `source ~/.zshrc` | Muat ulang pengaturan terminal |
| `tc` / `termcolors` | `nano ~/.termux/colors.properties` | Atur properti warna Termux |
| `c` | `clear` | Bersihkan layar bawah + cetak ulang header |
| `sd` | `cd /sdcard` | Pindah ke penyimpanan internal HP |
| `dl` | `cd /sdcard/Download` | Pindah ke folder Download |
| `up` | `pkg update && pkg upgrade -y` | Pembaruan seluruh paket Termux |
| `backup-termux` | Fungsi Kustom | Arsipkan `.zshrc` & `.termux` ke folder Download |
| `restore-termux` | Fungsi Kustom | Pulihkan konfigurasi dari arsip cadangan terbaru |

---

## 4. 🛠️ Pemecahan Masalah (Troubleshooting)

* **Terminal otomatis membuka `colors.properties` saat dimuat:**
Terjadi bentrok nama alias `colors` dengan fungsi internal modul warna Zsh. Pastikan baris pengaman `unalias colors 2>/dev/null` berada di bagian atas file `~/.zshrc`, lalu jalankan perintah `exec zsh` untuk membersihkan sesi memori.
* **Bingkai header kanan (`║`) bergeser atau miring:**
Disebabkan oleh perubahan panjang string variabel dinamis (seperti sisa kapasitas penyimpanan). Solusinya menggunakan penata format lebar tetap `printf` (misalnya `%-16s`) seperti yang sudah diterapkan di dalam fungsi `cybersmith_header()`.

---

## 5. 📜 Informasi Lisensi & Hak Cipta

Project **`thema-termuxx`** bersifat *Open Source* di bawah semangat berbagi ilmu dan pembelajaran bersama. Bebas digunakan, dimodifikasi, serta disebarluaskan kembali untuk tujuan kebaikan dan pengembangan skill pribadi.

---

## 6. 🤝 Kontak & Kontribusi

* **Kreator:** ar.abdulazis
* **Repositori GitHub:** [github.com/ar-abdulazis/thema-termuxx](https://www.google.com/search?q=https://github.com/ar-abdulazis/thema-termuxx)

---

### 👤 Profil Pembuat

> **NAMA** : ar.abdulazis <br>
> **STATUS** : Pembelajar Seumur Hidup & Penggagas Ide <br>
> **MESIN** : Digerakkan Ide, Dibantu AI <br>
> **HAK CIPTA** : Milik Allah Semata, kita mah bukan siapa-siapa. <br>
> *"Bukan ahli, cuma hamba yang sedang menjemput ilmu dan skill agar bermanfaat bagi diri, sesama, dan lingkungan."*

Dibuat dengan ⚡ dan dedikasi penuh di ekosistem Termux Android.

*Terima kasih telah berkunjung, semoga bermanfaat!*
