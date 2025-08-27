#!/bin/bash

echo "=== Memperbaiki DNS VPS ==="

# Backup resolv.conf lama
sudo cp /etc/resolv.conf /etc/resolv.conf.backup

# Ganti DNS ke Google & Cloudflare
cat <<EOF | sudo tee /etc/resolv.conf
nameserver 8.8.8.8
nameserver 1.1.1.1
nameserver 8.8.4.4
nameserver 9.9.9.9
EOF

# Lock file agar tidak di-overwrite otomatis
sudo chattr +i /etc/resolv.conf

echo "DNS sudah diganti ke Google & Cloudflare ✅"
echo ""
echo "=== Tes koneksi Internet ==="
ping -c 4 8.8.8.8

echo ""
echo "=== Tes DNS ke Google.com ==="
ping -c 4 google.com

echo ""
echo "Sudah mantap sayang ulun ae."