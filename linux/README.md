# 🐧 Linux Administration & Troubleshooting

This directory contains technical reference guides, architecture patterns, and automation scripts for Linux systems administration, performance tuning, and operational troubleshooting.

## 🗺️ Quick Reference Guide

#### 📌 Table of contents / Tabla de contenidos
- [File & Directory Operations](#file--directory-operations--operaciones-de-archivos-y-directorios)
- [Permissions & Ownership](#permissions--ownership--permisos-y-propietarios)
- [Text Processing & Searching](#text-processing--searching--procesamiento-de-texto-y-b%C3%BAsquedas)
- [Archive & Compression](#archive--compression--compresi%C3%B3n-y-archivado)
- [I/O Redirection & Pipelines](#io-redirection--pipelines--redirecci%C3%B3n-io-y-flujos-de-datos)
- [Networking & HTTP Requests](#networking--http-requests--redes-y-peticiones-http)
- [Process Management & System Diagnostics](#process-management--system-diagnostics--diagn%C3%B3stico-de-procesos-y-sistema)
- [Logs and Services (Systemd)](#logs-and-services-systemd--logs-y-servicios-systemd)
---

### File & Directory Operations / Operaciones de Archivos y Directorios

```bash
# Create nested directories / Crear directorios anidados
mkdir -p /tmp/app/logs/2026

# Copy files preserving timestamps and permissions / Copiar preservando atributos
cp -p file.txt backup_file.txt

# Copy directories recursively / Copiar directorios recursivamente
cp -r /src/folder /dst/folder

# Move or rename files / Mover o renombrar archivos
mv old_name.txt new_name.txt

# Remove files safely (prompt before deletion) / Eliminar pidiendo confirmación
rm -i sensitive_file.txt

# Force recursive removal of directories / Borrado recursivo forzado
rm -rf /tmp/temporary_folder

# Create symbolic links / Crear enlaces simbólicos
ln -s /var/log/nginx/access.log ~/current_access.log
```

### Permissions & Ownership / Permisos y Propietarios

```Bash
# Numeric permissions (755: rwxr-xr-x) / Permisos numéricos (Propietario, Grupo, Otros)
chmod 755 script.sh

# Symbolic permissions: Add execution to user / Añadir permiso de ejecución al usuario
chmod u+x script.sh

# Change file owner and group / Cambiar propietario y grupo
chown admin:devops /var/www/html/index.html

# Change ownership recursively / Cambiar propietario recursivamente
chown -R www-data:www-data /var/www/html/

# Check special permissions (SUID/SGID/Sticky Bit) / Ver permisos especiales y Umask actual
umask
```

### Text Processing & Searching / Procesamiento de Texto y Búsquedas

```bash
# Basic case-insensitive search / Búsqueda básica ignorando mayúsculas/minúsculas
grep -i "error" /var/log/syslog

# Recursive search with line numbers / Búsqueda recursiva con número de línea
grep -rn "DB_PASSWORD" /etc/config/

# Invert match (show lines NOT containing string) / Mostrar líneas que NO coinciden
grep -v "DEBUG" app.log

# Find files by name recursively / Buscar archivos por nombre
find /var/log -type f -name "*.log"

# Find files modified in the last 24 hours / Archivos modificados en las últimas 24h
find /home/user -type f -mtime -1

# Find and delete files larger than 100MB / Buscar y eliminar archivos > 100MB
find /var/tmp -type f -size +100M -exec rm -f {} \;

# Stream editor (SED): Replace text in file inline / Reemplazar texto en archivo
sed -i 's/http:\/\/localhost/https:\/\/[api.domain.com/g](https://api.domain.com/g)' config.env

# AWK: Print specific columns (e.g., column 1 and 3) / Imprimir columnas específicas
awk '{print $1, $3}' access.log
```

### Archive & Compression / Compresión y Archivado

```bash
# Create a tar.gz archive / Crear un archivo comprimido .tar.gz
tar -czvf archive.tar.gz /path/to/directory

# Extract a tar.gz archive / Extraer un archivo .tar.gz
tar -xzvf archive.tar.gz -C /target/destination/

# List contents of a tar.gz without extracting / Listar contenido sin extraer
tar -tzvf archive.tar.gz

# Zip a directory / Comprimir un directorio en .zip
zip -r backup.zip /path/to/directory

# Unzip an archive / Descomprimir archivo .zip
unzip backup.zip -d /target/destination/
```

### I/O Redirection & Pipelines / Redirección I/O y Flujos de Datos

```bash
# Redirect stdout to file (overwrite) / Redirigir stdout a archivo (sobrescribir)
echo "Configuration loaded" > app.log

# Redirect stdout to file (append) / Redirigir stdout a archivo (añadir al final)
echo "New entry" >> app.log

# Redirect stderr to file / Redirigir errores (stderr - FD 2) a archivo
ls /root 2> error.log

# Combine stdout and stderr to same file / Redirigir salida y errores al mismo archivo
./build-script.sh > build.log 2>&1
# Alternative syntax / Sintaxis alternativa moderna:
./build-script.sh &> build.log

# Discard output silently / Descartar salidas y errores silenciosamente
./noisy-script.sh > /dev/null 2>&1

# Pipe stdout to another command / Enlazar la salida con la entrada de otro comando
cat access.log | grep "404" | wc -l
```

### Networking & HTTP Requests / Redes y Peticiones HTTP

```bash
# List all active TCP/UDP ports with processes / Puertos activos TCP/UDP con procesos
ss -tulpn

# Trace network routing path to a destination host / Rastrear la ruta de red hacia un host de destino
traceroute 8.8.8.8

# Show network interfaces and IP address / Mostrar interfaces de red y direcciones IP
ip a

# Test remote TCP port connection / Probar conectividad TCP a un puerto remoto
nc -zv 10.0.1.50 22

# Curl: Download file saving original name / Descargar archivo guardando el nombre
curl -O [https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip](https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip)

# Curl: Inspect HTTP response headers / Inspeccionar cabeceras de respuesta HTTP
curl -I [https://api.github.com](https://api.github.com)

# Curl: Send POST request with JSON payload / Enviar petición POST con datos JSON
curl -X POST [https://api.example.com/v1/auth](https://api.example.com/v1/auth) \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "secretpassword"}'

# Curl: Send request passing custom authentication token / Enviar token de autenticación
curl -H "Authorization: Bearer YOUR_API_TOKEN" [https://api.example.com/data](https://api.example.com/data)

# Capture and filter traffic on a specific interface (e.g., eth0) looking for HTTP/DNS packets / Capturar y filtrar tráfico en una interfaz específica (ej. eth0) buscando paquetes HTTP/DNS
tcpdump -i eth0 -n -c 50 port 53 or port 80

# Analyze the path hop-by-hop with latency resolution (combination of ping + traceroute) / Analizar la ruta paso a paso con resolución de latencias (mezcla de ping + traceroute)
mtr -n --report 8.8.8.8
```

### Process Management & System Diagnostics / Diagnóstico de Procesos y Sistema

```bash
# List processes matching a specific name / Buscar procesos por nombre
pgrep -fl nginx

# Kill process by PID gracefully / Terminar proceso por PID de forma suave (SIGTERM)
kill 1234

# Force kill process / Forzar terminación de proceso (SIGKILL)
kill -9 1234

# Kill process by name / Terminar procesos por nombre
pkill -f python3

# Check system memory usage / Ver uso de memoria del sistema
free -h

# Monitor disk space usage / Monitorizar espacio de almacenamiento en disco
df -Th

# Interactive real-time process monitoring (sorted by memory/CPU) / Monitorización interactiva de procesos en tiempo real (ordenados por memoria/CPU)
top
htop

# Inspect virtual memory statistics and swap activity every 2 seconds / Inspeccionar estadísticas de memoria virtual y actividad de intercambio (swap) cada 2 segundos
vmstat 2

# Monitor real-time disk I/O / Diagnóstico de E/S en tiempo real cada 2s
iostat -xz 2

# Inspect kernel logs for errors (e.g., OOM Killer) / Ver errores en el buffer del kernel
dmesg -T | grep -i oom

# Find the top 10 largest directories in a specific path / Identificar los 10 directorios de mayor tamaño en una ruta específica
du -ah /var/log | sort -rh | head -n 10

# Inspect open files and associated processes / Inspeccionar archivos abiertos y procesos asociados
lsof -i :80

# Clear RAM cache without restarting services (only when the kernel fails to free buffers) / Vaciar la caché de la memoria RAM sin reiniciar servicios (solo cuando el kernel no libera búferes)
# 3 = frees pagecache, dentries, and inodes. Requires root privileges. / 3 = libera pagecache, dentries e inodes. Requiere permisos de root.
sync; echo 3 > /proc/sys/vm/drop_caches
```

### Logs and Services (Systemd) / Logs y Servicios (Systemd)

```bash
# Current service status / Estado actual del servicio
systemctl status nginx

# Real-time service logs / Logs en tiempo real del servicio
journalctl -u nginx -f --since "1 hour ago"
```