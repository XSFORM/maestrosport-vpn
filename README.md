# openvpn-xormask

Полный комплект для установки OpenVPN с obfuscation (scramble/xormask) и Telegram-бота мониторинга подключённых клиентов.

- Поддержка Ubuntu 20.04
- Быстрая установка и простой мониторинг через Telegram

## Состав
- Скрипт `install_openvpn_xor.sh` — установка OpenVPN + Scramble/XORMask
- Папка `monitor_bot/`:
  - `openvpn_monitor_bot.py` — код Telegram-бота
  - `requirements.txt` — зависимости для бота
- Папка `docs/` с дополнительными гайдами

## Установка

1. **Клонируем репозиторий**
   ```bash
   git clone https://github.com/XSFORM/openvpn-xormask.git
   cd openvpn-xormask
