#!/bin/bash
# script.sh — мониторинг ресурсов
# Раз в N секунд дописывает в monitor.log блок с free -h, df -h, uptime

INTERVAL=5
LOG="monitor.log"

echo "Скрипт запущен. Интервал: ${INTERVAL}с. Лог: ${LOG}"
while true; do
    echo "--- $(date '+%Y-%m-%d %H:%M:%S') ---" >> "$LOG"
    free -h >> "$LOG"
    df -h >> "$LOG"
    uptime >> "$LOG"
    sleep "$INTERVAL"
done
