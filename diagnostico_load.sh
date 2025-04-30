#!/bin/bash
# Diagnóstico de alto load no servidor Linux cPanel/WHM

echo "======= Diagnóstico de Load Alto ======="
echo ""
echo "⏱️  Load Average:"
uptime
echo ""

echo "📊 Top 10 processos por uso de CPU:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 11
echo ""

echo "📈 Top 10 processos por uso de memória:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 11
echo ""

echo "🔁 Verificando conexões localhost (127.0.0.1):"
netstat -plant | grep 127.0.0.1 | wc -l
netstat -plant | grep 127.0.0.1 | head -n 10
echo ""

echo "📬 Verificando fila de e-mails (Exim):"
exim -bp | exiqsumm | head -n 15
echo ""

echo "🕒 Verificando cronjobs ativos:"
echo "Crontab do root:"
crontab -l
echo ""

echo "Verificando crons em /etc/cron* e /var/spool/cron:"
ls -la /etc/cron* /var/spool/cron/
echo ""

echo "📂 Processos PHP em execução:"
ps aux | grep php | grep -v grep
echo ""

echo "🔧 Processos Laravel (artisan, schedule:work):"
ps aux | grep artisan | grep -v grep
echo ""

echo "✅ Fim do diagnóstico."
