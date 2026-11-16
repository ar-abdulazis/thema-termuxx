<div align="center">

# ⚡ thema-termuxx ASCII: Cybersmith

_Konfigurasi Zsh & Header Cyberpunk Kustom untuk Termux Android yang Ringan, Stabil, dan Presisi._

</div>
<img src="CyberSmith.png" alt="alt text" width="300">

---

## 1. 🚪 Pintu Gerbang Informasi

Selamat datang di repositori **`thema-termuxx`**! Project ini lahir dari eksperimen untuk menghadirkan antarmuka terminal Android (_Termux_) yang estetis dengan skema warna _Neon Cyberpunk_, namun tetap mengedepankan efisiensi kerja, keterbacaan data sistem _real-time_, serta stabilitas navigasi harian.

### Spesifikasi Utama:

- **Shell Framework:** Zsh + Oh My Zsh
- **Tema Visual:** Cybersmith Cyberfunk (Cyan `#05d9e8`, Magenta `#ff2a6d`, Cyber Gold `#ffb000`)
- **Sasaran Perangkat:** Termux di Android (Optimal pada mode Portrait & Landscape)

---

## 2. 🚀 Panduan Instalasi & Konfigurasi

Anda dapat memasang seluruh konfigurasi ini secara instan menggunakan **metode otomatis satu baris**, atau melalui metode manual.

### Metode Otomatis (Direkomendasikan - 1 Baris Perintah)

Cukup salin dan jalankan perintah berikut di terminal Termux Anda:

```bash
bash -c "$(curl -fsSL [https://raw.githubusercontent.com/ar-abdulazis/thema-termuxx/main/install.sh](https://raw.githubusercontent.com/ar-abdulazis/thema-termuxx/main/install.sh))"

```

_Skrip di atas akan secara otomatis memperbarui sistem, memasang dependensi (`git`, `curl`, `zsh`, `python`, `tar`), mengonfigurasi Oh My Zsh dan plugin, mencadangkan file lama, hingga mengunduh konfigurasi tema Cybersmith terbaru._

### Metode Manual (Opsional)

1. Perbarui sistem & instal paket pendukung:

```bash
pkg update && pkg upgrade -y && pkg install git curl zsh nano python tar -y

```

2. Beri izin akses penyimpanan:

```bash
termux-setup-storage

```

3. Unduh repositori dan pasang konfigurasi secara manual ke direktori utama (`~/`):

```bash
git clone [https://github.com/ar-abdulazis/thema-termuxx.git](https://github.com/ar-abdulazis/thema-termuxx.git) ~/thema-termuxx
cp ~/thema-termuxx/.zshrc ~/
mkdir -p ~/.termux
cp ~/thema-termuxx/*.properties ~/thema-termuxx/font.ttf ~/.termux/ 2>/dev/null
termux-reload-settings && exec zsh

```

---

## 3. ⚡ Penjelasan Fitur & Pengoperasian

- **Neural Terminal Header v2.6:** Banner ASCII kustom dengan panel statistik _real-time_ (Storage `/data`, Waktu, Tanggal, Versi Python, dan Arsitektur CPU) yang dikunci menggunakan format presisi agar bingkai kanan (`║`) tetap lurus.
- **Anti-Clear Header:** Fungsi _override_ pada perintah `clear` dan pintasan `Ctrl + L` memastikan layar kerja bawah bersih tanpa menghapus banner di bagian atas.
- **Custom Dual-Line Prompt:** Desain prompt dua baris neon cyan-magenta lengkap dengan integrasi status Git (`vcs_info`) secara otomatis.

### Ringkasan Shortcut (Aliases)

| Alias               | Perintah Asli / Fungsi                    | Fungsi Singkat                                        |
| ------------------- | ----------------------------------------- | ----------------------------------------------------- |
| `rc` / `zshrc`      | `nano ~/.zshrc`                           | Edit file konfigurasi Zsh                             |
| `rl` / `reload`     | `source ~/.zshrc`                         | Muat ulang pengaturan terminal                        |
| `tc` / `termcolors` | `nano ~/.termux/colors.properties`        | Atur properti warna Termux                            |
| `c`                 | `clear`                                   | Bersihkan layar bawah + cetak ulang header            |
| `sd`                | `cd /sdcard`                              | Pindah ke penyimpanan internal HP                     |
| `dl`                | `cd /sdcard/Download`                     | Pindah ke folder Download                             |
| `up`                | `pkg update && pkg upgrade -y`            | Pembaruan seluruh paket Termux                        |
| `update-thema`      | `exec bash -c "$(curl ... update.sh)"`    | Perbarui tema secara otomatis ke versi terbaru GitHub |
| `reset-thema`       | `exec bash -c "$(curl ... uninstall.sh)"` | Hapus tema & kembalikan Termux ke setelan awal        |
| `backup-termux`     | Fungsi Kustom                             | Arsipkan `.zshrc` & `.termux` ke folder Download      |
| `restore-termux`    | Fungsi Kustom                             | Pulihkan konfigurasi dari arsip cadangan terbaru      |

---

## 4. 🛠️ Pemecahan Masalah & Kemungkinan Kendala (_Troubleshooting_)

Berikut adalah beberapa kendala yang mungkin terjadi beserta solusi teknisnya:

- **Terminal otomatis membuka `colors.properties` saat dimuat:**
- **Penyebab:** Terjadi bentrok nama alias `colors` dengan fungsi internal modul warna Zsh.
- **Solusi:** Pastikan baris pengaman `unalias colors 2>/dev/null` berada di bagian atas file `~/.zshrc`, lalu jalankan perintah `exec zsh`.

- **Bingkai header kanan (`║`) bergeser atau miring:**
- **Penyebab:** Perubahan panjang string variabel dinamis (seperti sisa kapasitas penyimpanan).
- **Solusi:** Gunakan penata format lebar tetap `printf` (misalnya `%-16s`) seperti yang sudah diterapkan di dalam fungsi `cybersmith_header()`.

- **Perintah `update-thema` atau `reset-thema` memunculkan error `command not found`:**
- **Penyebab:** Sesi terminal aktif belum memuat alias terbaru yang ada di `~/.zshrc`.
- **Solusi:** Ketik `rl` atau `reload` terlebih dahulu untuk memuat ulang konfigurasi, atau pastikan file `.zshrc` di GitHub Anda sudah memuat alias manajemen tema.

- **Setelah menjalankan `reset-thema`, saat mengetik `exit` malah terpental kembali ke tema Cybersmith:**
- **Penyebab:** Skrip dijalankan di dalam _child process_ Bash sehingga proses Zsh induk masih aktif di memori latar belakang.
- **Solusi:** Pastikan alias menggunakan awalan `exec` (`exec bash -c "..."`) agar sesi Zsh lama dihancurkan total dan digantikan proses bersih.

---

## 5. 📜 Informasi Lisensi & Hak Cipta

Project **`thema-termuxx`** bersifat _Open Source_ di bawah semangat berbagi ilmu dan pembelajaran bersama. Bebas digunakan, dimodifikasi, serta disebarluaskan kembali untuk tujuan kebaikan dan pengembangan skill pribadi.

---

## 6. 🤝 Kontak & Kontribusi

- **Kreator:** ar.abdulazis
- **Repositori GitHub:** [github.com/ar-abdulazis/thema-termuxx](https://www.google.com/search?q=https://github.com/ar-abdulazis/thema-termuxx)

---

### 👤 Profil Pembuat

> **NAMA** : ar.abdulazis
>
> **STATUS** : Pembelajar Seumur Hidup & Penggagas Ide
>
> **MESIN** : Digerakkan Ide, Dibantu AI
>
> **HAK CIPTA** : Milik Allah Semata, kita mah bukan siapa-siapa.
>
> _"Bukan ahli, cuma hamba yang sedang menjemput ilmu dan skill agar bermanfaat bagi diri, sesama, dan lingkungan."_

Dibuat dengan ⚡ dan dedikasi penuh di ekosistem Termux Android.

_Terima kasih telah berkunjung, semoga bermanfaat!_

```

```
