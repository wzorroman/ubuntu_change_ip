#!/bin/bash

# Script para cambiar configuración de red en Ubuntu (Netplan)
# Autor: wilson zauma
# Uso: sudo ./cambiar_ip.sh

# -------------------------------------------------------------------
# Configuración deseada (modifica estos valores según necesites)
NUEVA_IP="10.23.62.108/24"
NUEVO_GATEWAY="10.23.62.1"
INTERFAZ="enp0s3"   # Reemplaza con tu interfaz de red (usa 'ip a' para verificar)
# -------------------------------------------------------------------

# Archivo de configuración Netplan
NETPLAN_FILE="/etc/netplan/00-installer-config.yaml"

# Verificar si el script se ejecuta como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script debe ejecutarse con sudo o como root" >&2
    exit 1
fi

# 1. Crear respaldo de la configuración actual
echo "[+] Creando respaldo de la configuración actual en /etc/netplan/00-installer-config.yaml.bak"
cp "$NETPLAN_FILE" "${NETPLAN_FILE}.bak"

# 2. Generar nueva configuración
echo "[+] Configurando nueva IP estática: $NUEVA_IP"
cat > "$NETPLAN_FILE" <<EOF
network:
  ethernets:
    $INTERFAZ:
      dhcp4: no
      addresses: [$NUEVA_IP]
      routes:
        - to: default
          via: $NUEVO_GATEWAY
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]
  version: 2
EOF

# 3. Aplicar cambios
echo "[+] Aplicando cambios de configuración..."
netplan apply

# Pequeña pausa para que los cambios surtan efecto
sleep 3

# 4. Verificar conexión
echo "[+] Verificando conectividad a internet..."
if ping -c 3 google.com &> /dev/null; then
    echo -e "\n✅ Configuración aplicada correctamente. Conexión a internet funcionando."
    echo -e "\nResumen de configuración:"
    ip addr show $INTERFAZ | grep "inet "
    ip route | grep default
else
    echo -e "\n⚠️  ¡Advertencia! No se pudo verificar la conexión a internet."
    echo "Revisa manualmente la configuración:"
    echo " - Archivo de configuración: $NETPLAN_FILE"
    echo " - Interfaz: $INTERFAZ"
    echo " - IP configurada: $NUEVA_IP"
    echo " - Gateway: $NUEVO_GATEWAY"
fi
