#!/bin/bash
# Скрипт: автоматизированная установка OpenVPN с поддержкой scramble/xormask

echo "[*] Установка базового OpenVPN..."
wget https://git.io/v1jlQ -O openvpn-install.sh && bash openvpn-install.sh

echo "[*] Удаляем базовый openvpn..."
apt remove openvpn -y

echo "[*] Устанавливаем OpenVPN с поддержкой xor (scramble)..."
wget https://raw.githubusercontent.com/x0r2d2/openvpn-xor/main/openvpn_xor_install.sh -O openvpn_xor_install.sh
chmod +x openvpn_xor_install.sh
bash openvpn_xor_install.sh

echo
echo "=== Для добавления/удаления клиентов используйте: ==="
echo "bash openvpn-install.sh"
