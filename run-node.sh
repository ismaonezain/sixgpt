#!/bin/bash

# Auto Node Script for SixGPT Miner (Vana Eco)
# Pastikan Anda memiliki saldo minimal 0.1 $VANA dan telah login ke sixgpt.xyz dengan wallet Anda.

# ------------------------
# Fungsi Utility
# ------------------------
function print_header() {
    echo "========================================="
    echo "    SixGPT Miner Auto Setup Script       "
    echo "========================================="
}

function check_prerequisites() {
    echo "Memeriksa prasyarat..."
    # Periksa apakah Docker terinstal
    if ! [ -x "$(command -v docker)" ]; then
        echo "Error: Docker tidak terinstal. Instal Docker terlebih dahulu."
        exit 1
    fi

    # Periksa apakah Git terinstal
    if ! [ -x "$(command -v git)" ]; then
        echo "Error: Git tidak terinstal. Instal Git terlebih dahulu."
        exit 1
    fi

    echo "Semua prasyarat telah terpenuhi!"
}

# ------------------------
# Konfigurasi Awal
# ------------------------
print_header
check_prerequisites

# Meminta pengguna memasukkan private key
read -p "Masukkan private key Anda: " PRIVATE_KEY

if [ -z "$PRIVATE_KEY" ]; then
    echo "Private key tidak boleh kosong! Harap ulangi proses."
    exit 1
fi

echo "Private key Anda telah diterima."

# Konfirmasi login ke sixgpt.xyz
echo "Pastikan Anda telah login ke sixgpt.xyz menggunakan wallet yang memiliki private key ini."
sleep 2

# ------------------------
# Menyiapkan Node
# ------------------------
echo "Cloning repository SixGPT Miner..."
git clone https://github.com/sixgpt/miner.git
cd miner || exit

echo "Membuat file konfigurasi .env..."
cat <<EOF >.env
VANA_PRIVATE_KEY=$PRIVATE_KEY
VANA_NETWORK=mainnet
OLLAMA_API_URL=http://ollama:11434/api
EOF

echo "Konfigurasi selesai!"

# ------------------------
# Menjalankan Node
# ------------------------
echo "Menjalankan SixGPT Miner dengan Docker Compose..."
docker-compose up -d

if [ $? -eq 0 ]; then
    echo "SixGPT Miner berhasil dijalankan!"
    echo "Gunakan 'docker-compose logs -f' untuk memantau aktivitas node Anda."
else
    echo "Terjadi kesalahan saat menjalankan node. Periksa konfigurasi atau hubungi dukungan."
    exit 1
fi
