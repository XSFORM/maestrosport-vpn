# OpenVPN + Scramble XOR

Полная установка OpenVPN с патчем XORMask и Telegram-мониторингом подключений.

---

## 🚀 Установка на Ubuntu 20.04

### 1. Подготовка сервера
```bash
apt update && apt upgrade -y
apt install wget unzip -y
```

### 2. Скачиваем и запускаем скрипт установки
```bash
wget https://raw.githubusercontent.com/XSFORM/openvpn-xormask/main/install_openvpn_xormask.sh -O install_openvpn_xormask.sh
chmod +x install_openvpn_xormask.sh
./install_openvpn_xormask.sh
```

Скрипт:
- Устанавливает OpenVPN XOR (scramble xormask)
- Прописывает `scramble xormask 5` в `server.conf` и `client-template.txt`
- Перемещает менеджер клиентов `openvpn-install.sh` в `/root/`

Для добавления/удаления клиентов:
```bash
cd /root
bash openvpn-install.sh
```

---

## 📟 Telegram-бот мониторинга

1. Установка Python:
```bash
apt install python3 python3-pip -y
```

2. Установка зависимостей:
```bash
cd monitor_bot
pip3 install -r requirements.txt
```

3. Настройка и запуск:
Открой `nano openvpn_monitor_bot.py`, вставь свой `TOKEN` и `CHAT_ID`, затем запусти:
```bash
python3 openvpn_monitor_bot.py
```

Бот будет отвечать на команды:
- `/start` — приветствие
- `/clients` — список активных подключений
- `/reboot` — перезапуск сервера (если включено)

---

## 📌 Примечания

- `scramble xormask` маскирует OpenVPN и помогает обходить Handshake заглушки.
- Все изменения в `server.conf` и шаблоне клиента (`client-template.txt`) вносятся автоматически.
- Сервер можно поднять как на `TCP`, так и на `UDP`.
- Бот не является обязательным, но полезен для мониторинга клиентов.

---

Автор: [XSFORM](https://github.com/XSFORM)
