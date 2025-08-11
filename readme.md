# Proyecto para automatizar el cambio de IP en ubuntu, definiendo una IP fija

## Instrucciones de uso:
    Guarda el script como cambiar_ip.sh

  1) Dale permisos de ejecución:
    ```bash
    chmod +x cambiar_ip.sh
    ```

  2) Ejecútalo con sudo:
    ```bash
    sudo ./cambiar_ip.sh
    ```

## Características del script:
  - Crea automáticamente un respaldo de tu configuración actual
  - Configura la IP estática, gateway y DNS (Google y Cloudflare)
  - Aplica los cambios con netplan apply
  - Verifica la conectividad a internet
  - Muestra información clara del resultado

## Notas importantes:
  - Verifica el nombre de tu interfaz de red con ip a (puede ser ens33, eth0, etc.)
  - Si necesitas cambiar la máscara de red, modifica el sufijo en NUEVA_IP (ej: /24)
  - Para revertir cambios, usa el archivo de respaldo creado (00-installer-config.yaml.bak)

# Haciendo Rollback de la configuracion
  Uso:
  a). Guarda el script como rollback_ip.sh
  b). Dale permisos de ejecución: chmod +x rollback_ip.sh
  c). Ejecútalo con privilegios: sudo ./rollback_ip.sh
