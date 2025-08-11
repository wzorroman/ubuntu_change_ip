#!/bin/bash

# Script para revertir la configuración de red a la versión anterior (Netplan)
# Uso: sudo ./rollback_ip.sh

# -------------------------------------------------------------------
# Archivo de configuración Netplan
NETPLAN_FILE="/etc/netplan/00-installer-config.yaml"
BACKUP_FILE="${NETPLAN_FILE}.bak"
# -------------------------------------------------------------------

# Verificar si el script se ejecuta como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script debe ejecutarse con sudo o como root" >&2
    exit 1
fi

# Verificar si existe el archivo de respaldo
if [ ! -f "$BACKUP_FILE" ]; then
    echo "Error: No se encontró el archivo de respaldo ($BACKUP_FILE)" >&2
    echo "No hay configuración previa para restaurar" >&2
    exit 1
fi

# 1. Restaurar el respaldo
echo "[+] Restaurando configuración anterior desde $BACKUP_FILE"
cp "$BACKUP_FILE" "$NETPLAN_FILE"

# 2. Aplicar cambios
echo "[+] Aplicando cambios de configuración..."
netplan apply

# Pequeña pausa para que los cambios surtan efecto
sleep 3
