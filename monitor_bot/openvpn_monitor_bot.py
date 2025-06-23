import os
from telegram import Update
from telegram.ext import ApplicationBuilder, CommandHandler, ContextTypes

TELEGRAM_TOKEN = "твой токен бота"
ADMIN_ID = твой id telegram

OPENVPN_STATUS_LOG = "/var/log/openvpn/status.log"

async def start(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.effective_user.id != ADMIN_ID:
        await update.message.reply_text("⛔ Нет доступа")
        return
    await update.message.reply_text("✅ MaestroSport VPN Monitor активен!")

async def clients(update: Update, context: ContextTypes.DEFAULT_TYPE):
    if update.effective_user.id != ADMIN_ID:
        await update.message.reply_text("⛔ Нет доступа")
        return
    if not os.path.exists(OPENVPN_STATUS_LOG):
        await update.message.reply_text("Файл status.log не найден")
        return

    with open(OPENVPN_STATUS_LOG) as f:
        lines = f.readlines()

    clients = []
    active = False
    for line in lines:
        if line.startswith("Common Name,Real Address"):
            active = True
            continue
        if active:
            if line.strip() == "ROUTING TABLE":
                break
            parts = line.strip().split(",")
            if len(parts) >= 2:
                name = parts[0]
                ip_port = parts[1]
                clients.append(f"{name} ({ip_port})")

    if not clients:
        await update.message.reply_text("Нет активных клиентов")
    else:
        msg = "📊 Подключённые клиенты:\n" + "\n".join(clients)
        await update.message.reply_text(msg)

if __name__ == "__main__":
    app = ApplicationBuilder().token(TELEGRAM_TOKEN).build()
    app.add_handler(CommandHandler("start", start))
    app.add_handler(CommandHandler("clients", clients))
    print("Бот запущен!")
    app.run_polling()
