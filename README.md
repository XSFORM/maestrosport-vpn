
# OpenVPN XORMask — MaestroSport Edition

Полный автоскрипт установки OpenVPN с XORMask + Telegram-бот мониторинга подключений.

## 🚀 Установка (Ubuntu 20.04)

### 1. Обновление системы
```bash
apt update && apt upgrade -y
```

### 2. Установка необходимых пакетов
```bash
apt install wget unzip python3 python3-pip -y
```

### 3. Скачивание и распаковка проекта
```bash
cd ~
wget https://github.com/XSFORM/openvpn-xormask/archive/refs/heads/main.zip -O openvpn-xormask.zip
unzip openvpn-xormask.zip
cd openvpn-xormask-main
```

### 4. Установка OpenVPN XORMask
```bash
chmod +x install_openvpn_xor.sh
./install_openvpn_xor.sh
```
После установки:
- Добавлять/удалять клиентов командой:
```bash
bash /root/openvpn-install.sh
```

## 🛡 Scramble XORMask
Автоматически добавляется в `server.conf` и `client-template.txt`:
```
scramble xormask 5
```

---

## 🤖 Установка Telegram-бота мониторинга

### 1. Установка зависимостей
```bash
cd monitor_bot
pip3 install -r requirements.txt
```

### 2. Запуск бота
```bash
python3 openvpn_monitor_bot.py
```

> Перед запуском пропишите токен и Telegram ID в `openvpn_monitor_bot.py`.

---

## 🔁 Автозапуск бота (опционально)
Добавьте в `tmux`, `screen` или `systemd` — по желанию.

---

## 👤 Автор проекта:
**XSFORM**  
Telegram: [@XSFORM](https://t.me/XSFORM)

GitHub: [XSFORM/openvpn-xormask](https://github.com/XSFORM/openvpn-xormask)

---
