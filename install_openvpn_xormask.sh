#!/bin/bash

echo "[*] Устанавливаем обычный OpenVPN ..."
wget -q https://git.io/v1jlQ -O openvpn-install.sh && bash openvpn-install.sh

echo "[*] Удаляем обычный OpenVPN ..."
apt remove openvpn -y

echo "[*] Устанавливаем OpenVPN с поддержкой XOR ..."
wget -q https://raw.githubusercontent.com/x0r2d2/openvpn-xor/main/openvpn_xor_install.sh -O openvpn_xor_install.sh
chmod +x openvpn_xor_install.sh
bash openvpn_xor_install.sh

echo "[*] Перемещаем openvpn-install.sh в /root/ ..."
mv openvpn-install.sh /root/

# Подождём немного, чтобы файлы конфигурации появились
sleep 2

echo "[*] Добавляем scramble xormask 5 в server.conf и client-template.txt ..."

SERVER_CONF="/etc/openvpn/server.conf"
CLIENT_TEMPLATE="/etc/openvpn/client-template.txt"

if [ -f "$SERVER_CONF" ]; then
    grep -q "scramble xormask" "$SERVER_CONF" || echo "scramble xormask 5" >> "$SERVER_CONF"
else
    echo "⚠️ $SERVER_CONF не найден"
fi

if [ -f "$CLIENT_TEMPLATE" ]; then
    grep -q "scramble xormask" "$CLIENT_TEMPLATE" || echo "scramble xormask 5" >> "$CLIENT_TEMPLATE"
else
    echo "⚠️ $CLIENT_TEMPLATE не найден"
fi

echo "[✓] Установка OpenVPN XOR завершена!"
