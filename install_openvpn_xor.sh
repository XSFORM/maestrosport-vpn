#!/bin/bash
set -e

# 0) Функция ожидания разблокировки apt/dpkg
wait_for_lock() {
  echo "[*] Проверяем блокировку apt/dpkg..."
  # Ждём, пока не уберётся любой lock на apt или dpkg
  while sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 \
     || sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1 \
     || sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1; do
    echo "    Ждём освобождения lock-файла..."
    sleep 2
  done
}

# 1) Установка базового OpenVPN
wait_for_lock
echo "[*] Установка базового OpenVPN..."
wget https://git.io/v1jlQ -O openvpn-install.sh
bash openvpn-install.sh

# 2) Остановка auto-обновлений (unattended-upgrades), чтобы не мешали apt remove
if systemctl is-active --quiet unattended-upgrades; then
  echo "[*] Останавливаем unattended-upgrades..."
  systemctl stop unattended-upgrades
fi

# 3) Удаление стандартного пакета openvpn
wait_for_lock
echo "[*] Удаляем базовый openvpn..."
apt remove openvpn -y

# 4) Снова даём системе время, если были фоновые операции
wait_for_lock

# 5) Установка OpenVPN с патчем XOR/Scramble
echo "[*] Устанавливаем OpenVPN с поддержкой XOR/Scramble..."
wget https://raw.githubusercontent.com/x0r2d2/openvpn-xor/main/openvpn_xor_install.sh -O openvpn_xor_install.sh
chmod +x openvpn_xor_install.sh
bash openvpn_xor_install.sh

# 6) Включаем обратно unattended-upgrades
if systemctl list-unit-files | grep -q unattended-upgrades; then
  echo "[*] Запускаем unattended-upgrades обратно..."
  systemctl start unattended-upgrades || true
fi

echo "=== Установка OpenVPN XOR завершена! ==="
echo "Для добавления/удаления клиентов используйте:"
echo "    bash openvpn-install.sh"
