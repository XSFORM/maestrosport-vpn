#!/bin/bash

echo "[*] Проверяем блокировку apt/dpkg..."
while sudo fuser /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock >/dev/null 2>&1 ; do
    echo "    Ждём освобождения lock-файла..."
    sleep 3
done

echo "[*] Устанавливаем патченый OpenVPN с XOR..."

wget https://raw.githubusercontent.com/x0r2d2/openvpn-xor/main/openvpn_xor_install.sh -O /tmp/openvpn_xor_install.sh
chmod +x /tmp/openvpn_xor_install.sh
bash /tmp/openvpn_xor_install.sh

echo "[*] Перемещаем openvpn-install.sh в /root/ ..."
if [ -f openvpn-install.sh ]; then
    mv openvpn-install.sh /root/openvpn-install.sh
    chmod +x /root/openvpn-install.sh
    echo "    Скрипт перемещён: /root/openvpn-install.sh"
fi

echo "[*] Добавляем scramble xormask 5 в server.conf и client-template.txt ..."
SERVER_CONF="/etc/openvpn/server.conf"
CLIENT_TEMPLATE="/etc/openvpn/client-template.txt"

# Только если не существует строки scramble
grep -qxF "scramble xormask 5" "$SERVER_CONF" || echo "scramble xormask 5" >> "$SERVER_CONF"
grep -qxF "scramble xormask 5" "$CLIENT_TEMPLATE" || echo "scramble xormask 5" >> "$CLIENT_TEMPLATE"

echo "[✓] Установка и настройка завершены!"
