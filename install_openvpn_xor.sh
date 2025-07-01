#!/bin/bash

echo "[*] Удаляем стандартный OpenVPN..."
apt remove --purge openvpn -y

echo "[*] Устанавливаем OpenVPN XOR (xormask)..."
wget https://raw.githubusercontent.com/x0r2d2/openvpn-xor/main/openvpn_xor_install.sh -O openvpn_xor_install.sh
chmod +x openvpn_xor_install.sh
./openvpn_xor_install.sh

echo "[*] Перемещаем openvpn-install.sh в /root/ ..."
mv openvpn-install.sh /root/

echo "[*] Добавляем scramble xormask 5 в server.conf и client-template.txt ..."
SERVER_CONF="/etc/openvpn/server.conf"
CLIENT_TEMPLATE="/etc/openvpn/client-template.txt"

if [ -f "$SERVER_CONF" ]; then
  grep -q "scramble xormask" "$SERVER_CONF" || echo "scramble xormask 5" >> "$SERVER_CONF"
else
  echo "[!] Файл $SERVER_CONF не найден. Добавьте строку вручную после создания клиента."
fi

if [ -f "$CLIENT_TEMPLATE" ]; then
  grep -q "scramble xormask" "$CLIENT_TEMPLATE" || echo "scramble xormask 5" >> "$CLIENT_TEMPLATE"
else
  echo "[!] Файл $CLIENT_TEMPLATE не найден. Добавьте строку вручную после создания клиента."
fi
