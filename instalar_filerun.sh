#!/bin/bash

# Pregunta al usuario si es Unraid o Synology
echo "Seleccione el sistema para el que desea ejecutar el script:"
echo "1) Unraid"
echo "2) Synology"
read -p "Ingrese 1 o 2: " system_choice

# Crear directorio de trabajo
mkdir -p filerun_btf

# Descargar el archivo
wget -O filerun_btf/filerun.tar.gz "https://github.com/unraiders/filerun/raw/main/filerun.tar.gz"

# Cambiar al directorio de trabajo
cd filerun_btf

# Descomprimir el archivo descargado
tar -xzvf filerun.tar.gz

# Función para preguntar al usuario por la ruta
ask_for_path() {
    local default_path="$1"
    local file_name="$2"
    
    # Mostrar la ruta predeterminada y preguntar al usuario si quiere cambiarla
    read -p "Ruta predeterminada para $file_name: $default_path. Presiona Enter para usarla o ingresa una nueva ruta: " user_path

    # Usar la ruta predeterminada si el usuario no ingresa nada
    if [ -z "$user_path" ]; then
        echo "$default_path"
    else
        echo "$user_path"
    fi
}

if [ "$system_choice" -eq 1 ]; then
    # Procesar archivos para Unraid
    echo "Ha seleccionado Unraid."

    # Preguntar por las rutas para Unraid
    filerun_unraid_path=$(ask_for_path "/mnt/user/appdata/" "filerun.tar.gz en Unraid")
    my_filerun_unraid_path=$(ask_for_path "/boot/config/plugins/dockerMan/templates-user/" "my-filerun.xml en Unraid")

    # Descomprimir y copiar archivos para Unraid
    echo "Descomprimiendo y copiando archivos en Unraid..."
    tar -xzvf filerun.tar.gz -C "$filerun_unraid_path"
    cp my-filerun.xml "$my_filerun_unraid_path"
    echo "Ahora tienes la plantilla disponible para su instalación"
    echo "RECUERDA instalar una base de datos de MariaDB"

elif [ "$system_choice" -eq 2 ]; then
    # Procesar archivos para Synology
    echo "Ha seleccionado Synology."

    # Preguntar por las rutas para Synology
    filerun_synology_path=$(ask_for_path "/volume1/docker/" "filerun.tar.gz en Synology")

    # Descomprimir archivos para Synology
    echo "Descomprimiendo archivos en Synology..."
    tar -xzvf filerun.tar.gz -C "$filerun_synology_path"
    echo "Proceso finalizado."
    echo "Tienes el compose.yaml en la ubicación " $filerun_synology_path
    mkdir $filerun_synology_path/filerun_db
    echo "Si lo instalas como Proyecto se instala Filerun y MariaDB"
else
    echo "Opción no válida. Por favor, ejecute el script de nuevo y elija 1 o 2."
    exit 1
fi

echo "Proceso completado."
