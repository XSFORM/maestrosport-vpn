
# OpenVPN (XOR + Telegram Bot)

Полнофункциональная установка OpenVPN с патчем scramble XOR + Telegram-бот мониторинга подключений.

---

## 🔧 Установка VPN-сервера на Ubuntu 20.04

1. **Подключитесь к серверу:**

   ```bash
   ssh root@IP_СЕРВЕРА
   ```

2. **Обновите систему и установите необходимые пакеты:**

   ```bash
   apt update && apt upgrade -y
   apt install wget curl unzip -y
   ```

3. **Клонируйте репозиторий:**

   ```bash
   git clone https://github.com/XSFORM/openvpn-xormask.git
   cd openvpn-xormask
   ```

4. **Установите OpenVPN с патчем XOR:**

   ```bash
   chmod +x install_openvpn_xor.sh
   ./install_openvpn_xor.sh
   ```

   ➤ После установки конфигурация сервера и шаблон клиента будут уже с параметром `scramble xormask 5`.

5. **Добавление / удаление клиентов:**

   ```bash
   bash openvpn-install.sh
   ```

---

## 🤖 Установка Telegram-бота мониторинга клиентов

1. **Установите Python и pip:**

   ```bash
   apt install python3 python3-pip -y
   ```

2. **Перейдите в директорию бота и установите зависимости:**

   ```bash
   cd monitor_bot
   pip3 install -r requirements.txt
   ```

3. **Настройте файл `openvpn_monitor_bot.py`:**

   Вставьте свой Telegram токен и Telegram ID:

   ```python
   TELEGRAM_TOKEN = "ВАШ_ТОКЕН"
   TELEGRAM_USER_ID = ВАШ_ID
   ```

4. **Запустите бота:**

   ```bash
   python3 openvpn_monitor_bot.py
   ```

---

## ⚙ Автозапуск бота (опционально)

Рекомендуется использовать `tmux` или `screen`, либо настроить systemd:

```bash
apt install tmux -y
tmux new -s vpn-bot
cd /root/openvpn-xormask/monitor_bot
python3 openvpn_monitor_bot.py
```

Для выхода из tmux: `Ctrl+B`, затем `D`.

---

## ✅ Готово!

Теперь вы можете отправлять в Telegram:

- `/start` — для проверки связи,
- `/clients` — список подключённых клиентов и их IP.

---

## 👤 Автор: XSFORM & MaestroSport VPN Team
