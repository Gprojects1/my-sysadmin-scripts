#!/bin/bash
# script.sh — мониторинг ресурсов
# Раз в N секунд дописывает в monitor.log блок с free -h, df -h, uptime

set -euo pipefail

INTERVAL="${1:-5}"
LOG="${2:-monitor.log}"

if ! [[ "$INTERVAL" =~ ^[0-9]+$ ]] || [ "$INTERVAL" -lt 1 ]; then
    echo "Ошибка: интервал должен быть целым числом ≥ 1" >&2
    exit 1
fi

if ! touch "$LOG" 2>/dev/null; then
    echo "Ошибка: нет прав на запись в $LOG" >&2
    exit 1
fi

echo "Скрипт запущен. Интервал: ${INTERVAL}с. Лог: ${LOG}"
trap 'echo "Остановлено."; exit 0' INT TERM

while true; do
    {
        echo "--- $(date '+%Y-%m-%d %H:%M:%S') ---"
        free -h
        df -h
        uptime
    } >> "$LOG"
    sleep "$INTERVAL"
done
