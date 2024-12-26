#!/bin/bash

# Cek apakah `git` terinstal
if ! command -v git &> /dev/null; then
    echo "Git tidak ditemukan, silakan instal Git terlebih dahulu."
    exit 1
fi

# Cek apakah `docker` terinstal
if ! command -v docker &> /dev/null; then
    echo "Docker tidak ditemukan, silakan instal Docker terlebih dahulu."
    exit 1
fi

# Clone repositori
echo "Mengunduh repositori..."
git clone https://github.com/sixgpt/miner.git || {
    echo "Gagal mengunduh repositori."
    exit 1
}

# Masuk ke direktori repositori
cd miner || {
    echo "Direktori 'miner' tidak ditemukan."
    exit 1
}

# Jalankan Docker
echo "Menjalankan node menggunakan Docker..."
docker-compose up -d || {
    echo "Gagal menjalankan Docker Compose."
    exit 1
}

echo "Node berhasil dijalankan! Silakan cek statusnya."
