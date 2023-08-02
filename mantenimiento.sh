#!/bin/bash

# Colores y estilo para el menú
verde=$(tput setaf 2)   # Color verde
rojo=$(tput setaf 1)     # Color rojo
amarillo=$(tput setaf 3)   # Color amarillo
azul=$(tput setaf 4)     # Color azul
normal=$(tput sgr0)      # Restaurar color por defecto
negrita=$(tput bold)     # Texto en negrita

# Función para comprobar y, si es necesario, instalar la dependencia tput
function verificar_tput() {
      if ! command -v tput &>/dev/null; then

        echo -n "${amarillo}La herramienta 'tput' no está instalada. Instalando."
        for _ in {1..3}; do
            echo -n " . "
            sleep 1
        done
        echo "${normal}"
        if [[ "$(uname)" == "Linux" ]]; then
            sudo apt-get update
            sudo apt-get install -y ncurses-bin
        else
            clear
            echo
            echo "${amarillo}Comprobando dependencias. "
            for _ in {1..3}; do
                echo -n " . "
                sleep 1
            done
            echo "${rojo}No se pudo detectar el sistema operativo. Por favor, instala 'tput' manualmente o no se verán los colores.${normal}"
            sleep 3
            exit 1
        fi

        clear
        echo -n "${amarillo}Comprobando dependencias."
        for _ in {1..3}; do
            echo -n " . "
            sleep 1
        done
        echo "${normal}"
        echo "${verde}¡'tput' se ha instalado correctamente!${normal}"
        sleep 3
    else
        clear
        echo -n "${amarillo}Comprobando dependencias."
        for _ in {1..3}; do
            echo -n " . "
            sleep 1
        done
        echo "${normal}"
        echo "${verde}¡Todas las dependencias necesarias para una correcta visualización están instaladas en el sistema!${normal}"
        sleep 3
    fi
}
# Llamada a la función verificar_tput para comprobar si tput está instalado
verificar_tput

# Función para mostrar la cabecera
function cabecera() {
    echo "${negrita}${verde}==============================="
    echo "  $1"
    echo "===============================${normal}"
}

# Función para seleccionar un directorio y listar su contenido
function listar_contenido_directorio() {
    clear
    cabecera "Listar contenido de un directorio"
    read -p "${negrita}${amarillo}Escribe la ruta del directorio: ${normal}" directorio

    # Verificar si el directorio existe
    if [[ ! -d "$directorio" ]]; then
        echo "${negrita}${rojo}El directorio \"$directorio\" no existe. La operación ha sido abortada.${normal}"
        return
    fi

    ls -la "$directorio"
}

# Función para crear un fichero con comprobación de existencia de la ruta
function crear_fichero() {
    clear
    cabecera "Crear un fichero"
    read -p "${negrita}${amarillo}Escribe la ruta del directorio donde desea crear el fichero: ${normal}" directorio

    # Verificar si el directorio existe
    if [[ ! -d "$directorio" ]]; then
        echo "${negrita}${rojo}El directorio \"$directorio\" no existe. La creación del fichero ha sido abortada.${normal}"
        return
    fi

    read -p "${negrita}${amarillo}Escribe el nombre del fichero: ${normal}" nombre_fichero

    touch "$directorio/$nombre_fichero"
    echo "Fichero creado: $directorio/$nombre_fichero"
}

# Función para leer un fichero indicado por el usuario
function leer_fichero() {
	clear
    cabecera "Leer un fichero"
    read -p "${negrita}${amarillo}Escribe la ruta del fichero que quieres leer: ${normal}" fichero
    if [ -f "$fichero" ]; then
        cat "$fichero"
    else
        echo "${negrita}${rojo}El fichero no existe.${normal}"
    fi
}

# Función para editar un fichero indicado por el usuario
function editar_fichero() {
	clear
    cabecera "Editar un fichero"
    read -p "${negrita}${amarillo}Escribe la ruta del fichero que quieres editar: ${normal}" fichero
    if [ -f "$fichero" ]; then
        nano "$fichero"
    else
        echo "${negrita}${rojo}El fichero no existe.${normal}"
    fi
}

# Función para copiar un fichero de un directorio a otro
function copiar_fichero() {
    clear
    cabecera "Copiar un fichero"
    read -p "${negrita}${amarillo}Escribe la ruta del fichero que desea copiar: ${normal}" origen

    # Comprobar si el archivo de origen existe
    if [[ ! -e "$origen" ]]; then
        echo "${negrita}${rojo}El archivo de origen no existe.${normal}"
        return
    fi

    read -p "${negrita}${amarillo}Escribe la ruta del directorio de destino: ${normal}" destino

    # Comprobar si la ruta de destino existe
    if [[ ! -d "$destino" ]]; then
        echo "${negrita}${rojo}El directorio de destino no existe.${normal}"
        return
    fi

    cp "$origen" "$destino"
    echo "${negrita}${verde}Fichero copiado a $destino${normal}"
}

# Función para mover un fichero de un directorio a otro
function mover_fichero() {
    clear
    cabecera "Mover un fichero"
    read -p "${negrita}${amarillo}Escribe la ruta del fichero que desea mover: ${normal}" origen

    # Comprobar si el archivo de origen existe
    if [[ ! -e "$origen" ]]; then
        echo "${negrita}${rojo}El archivo de origen no existe.${normal}"
        return
    fi

    read -p "${negrita}${amarillo}Escribe la ruta del directorio de destino: ${normal}" destino

    # Comprobar si la ruta de destino existe
    if [[ ! -d "$destino" ]]; then
        echo "${negrita}${rojo}El directorio de destino no existe.${normal}"
        return
    fi

    # Con -i se sobreescribe el detino, en caso de existir
    mv -i "$origen" "$destino"
    echo "${negrita}${verde}Fichero movido a $destino${normal}"
}

# Función para eliminar ficheros indicados por el usuario
function eliminar_ficheros() {
	clear
    cabecera "Eliminar ficheros"
    read -p "${negrita}${amarillo}Escribe una lista de ficheros separados por espacio que desea eliminar: ${normal}" ficheros

    # Verificar si se ingresaron archivos
    if [ -z "$ficheros" ]; then
        echo "${negrita}${rojo}No se escribieron nombres de ficheros para eliminar.${normal}"
        return
    fi

    # Mostrar la lista de ficheros a eliminar
    echo "${negrita}${azul}Los siguientes ficheros serán eliminados:${normal}"
    echo "$ficheros"

    # Pedir confirmación antes de eliminar
    read -p "${negrita}${rojo}¿Estás MUY seguro de que quieres eliminar estos ficheros? (S/n): ${normal}" confirmacion

    # Convertir la confirmación a minúsculas para hacerla insensible a mayúsculas o minúsculas
    confirmacion=${confirmacion,,}

    if [ "$confirmacion" == "s" ]; then
        rm -i $ficheros
        echo "${negrita}${verde}Ficheros eliminados exitosamente.${normal}"
    else
        echo "${negrita}${rojo}La operación de eliminación fue cancelada.${normal}"
    fi
}

# Función para mostrar los permisos de un fichero o directorio
function mostrar_permisos() {
	clear
    cabecera "Mostrar permisos de un fichero o directorio"
    read -p "${negrita}${amarillo}Escribe la ruta del fichero o directorio: ${normal}" ruta
    ls -ld "$ruta"
}

# Función para instalar un paquete determinado si existe en los repositorios
function instalar_paquete() {
	clear
    cabecera "Instalar paquete"
    read -p "${negrita}${amarillo}Escribe el nombre del paquete que desea instalar: ${normal}" paquete
    
    # Redirigir tanto la salida estándar (stdout) como la salida de error (stderr) a /dev/null
    if apt-cache show "$paquete" &>/dev/null; then
        sudo apt-get install "$paquete"
    else
        echo "${negrita}${rojo}El paquete $paquete no se encuentra en los repositorios, por lo que no se puede instalar${normal}"
    fi
}

# Función para matar un proceso seleccionado por el usuario
function matar_proceso() {
	clear
    cabecera "Matar un proceso"
    
    # Mostrar los 10 procesos que más recursos consumen
    echo "${negrita}${amarillo}Los 10 procesos que más recursos consumen:${normal}"
    ps aux --sort=-%cpu | head -n 11

    # Mostrar los procesos que están colgados
    echo "${negrita}${amarillo}Los procesos que están colgados:${normal}"
    ps aux | awk '$8 ~ /D/ { print }'

    # Pedir al usuario que indique el proceso a matar
    read -p "${negrita}${amarillo}Escribe el nombre o PID del proceso que desea matar: ${normal}" proceso

    # Mostrar el proceso a matar
    echo "${negrita}${amarillo}Proceso a matar: ${normal} $proceso"

    # Pedir confirmación antes de matar
    read -p "${negrita}${rojo}¿Está seguro de que desea matar este proceso? (S/n): ${normal}" confirmacion

    # Convertir la confirmación a minúsculas para hacerla insensible a mayúsculas o minúsculas
    confirmacion=${confirmacion,,}

    if [ "$confirmacion" == "s" ]; then
        # Enviar la señal SIGTERM (15) al proceso para terminarlo adecuadamente
        kill -15 $proceso
        echo "${negrita}${verde}Proceso terminado: ${normal} $proceso"
    else
        echo "${negrita}${rojo}La operación de terminación fue cancelada.${normal}"
    fi
}

# Función para listar los usuarios del sistema
function listar_usuarios() {
	clear
    cabecera "${negrita}${amarillo}Listar usuarios del sistema${normal}"
    cut -d: -f1 /etc/passwd
}

# Función para crear un usuario
function crear_usuario() {
	clear
    cabecera "Crear un usuario"
    read -p "${negrita}${amarillo}Escribe el nombre del usuario que quieres crear: {normal}" usuario
    sudo useradd "$usuario"
    echo "${negrita}${verde}Usuario creado: ${normal} $usuario"
}

# Función para desactivar un usuario
function desactivar_usuario() {
	clear
    cabecera "Desactivar un usuario"
    read -p "${negrita}${amarillo}Escribe el nombre del usuario que quieres desactivar: ${normal}" usuario

    # Mostrar el nombre del usuario a desactivar
    echo "${negrita}${amarillo}Usuario a desactivar: ${normal} $usuario"

    # Pedir confirmación antes de desactivar
    read -p "${negrita}${rojo}¿Está seguro de que desea desactivar este usuario? (S/n): ${normal}" confirmacion

    # Convertir la confirmación a minúsculas para hacerla insensible a mayúsculas o minúsculas
    confirmacion=${confirmacion,,}

    if [ "$confirmacion" == "s" ]; then
        sudo usermod -L "$usuario"
        echo "${negrita}${verde}Usuario desactivado: ${normal} $usuario"
    else
        echo "${negrita}${rojo}La operación de desactivación fue cancelada.${normal}"
    fi
}

# Función para eliminar un usuario
function eliminar_usuario() {
	clear
    cabecera "Eliminar un usuario"
    read -p "${negrita}${amarillo}Escribe el nombre del usuario que quieres eliminar: ${normal}" usuario

    # Mostrar el nombre del usuario a eliminar
    echo "${negrita}${amarillo}Usuario a eliminar: ${normal} $usuario"

    # Pedir confirmación antes de eliminar
    read -p "${negrita}${rojo}¿Está seguro de que desea eliminar este usuario? (S/n): ${normal}" confirmacion

    # Convertir la confirmación a minúsculas para hacerla insensible a mayúsculas o minúsculas
    confirmacion=${confirmacion,,}

    if [ "$confirmacion" == "s" ]; then
        sudo userdel "$usuario"
        echo "${negrita}${verde}Usuario eliminado: ${normal} $usuario"
    else
        echo "${negrita}${rojo}La operación de eliminación fue cancelada.${normal}"
    fi
}

# Función para crear un grupo
function crear_grupo() {
    clear
    cabecera "Crear un grupo"
    read -p "${negrita}${amarillo}Escribe el nombre del nuevo grupo: ${normal}" grupo

    # Verificar si el grupo ya existe en el sistema
    if getent group "$grupo" >/dev/null; then
        echo "${negrita}${rojo}El grupo \"$grupo\" ya existe en el sistema. La creación del grupo ha sido cancelada.${normal}"
        return
    fi

    sudo groupadd "$grupo"
    echo "${negrita}${verde}Grupo creado: ${normal} $grupo"
}

# Función para listar los grupos del sistema
function listar_grupos() {
	clear
    cabecera "Listar grupos del sistema"
	echo "${negrita}${amarillo}Grupos encontrados en el sistema:${normal}"
    cut -d: -f1 /etc/group
}

# Función para eliminar un grupo
function eliminar_grupo() {
	clear
    cabecera "Eliminar un grupo"
    read -p "${negrita}${amarillo}Escribe el nombre del grupo que quieras eliminar: ${normal}" grupo

    # Mostrar el nombre del grupo a eliminar
    echo "${negrita}${amarillo}Grupo a eliminar: ${normal} $grupo"

    # Pedir confirmación antes de eliminar
    read -p "${negrita}${rojo}¿Está seguro de que desea eliminar este grupo? (S/n): ${normal}" confirmacion

    # Convertir la confirmación a minúsculas para hacerla insensible a mayúsculas o minúsculas
    confirmacion=${confirmacion,,}

    if [ "$confirmacion" == "s" ]; then
        sudo groupdel "$grupo"
        echo "${negrita}${verde}Grupo eliminado: ${normal} $grupo"
    else
        echo "${negrita}${rojo}La operación de eliminación fue cancelada.${normal}"
    fi
}

# Función para asignar usuarios a grupos
function asignar_usuarios_a_grupo() {
    clear
    cabecera "Asignar usuarios a un grupo"
    read -p "${negrita}${amarillo}Escribe el nombre del grupo: ${normal}" grupo

    # Verificar si el grupo existe en el sistema
    if ! getent group "$grupo" >/dev/null; then
        echo "${negrita}${rojo}El grupo \"$grupo\" no existe en el sistema. La asignación de usuarios ha sido abortada.${normal}"
        return
    fi

    read -p "${negrita}${amarillo}Escribe una lista de usuarios separados por espacio que quieras añadir al grupo: ${normal}" usuarios

    # Verificar si todos los usuarios existen en el sistema
    for usuario in $usuarios; do
        if ! getent passwd "$usuario" >/dev/null; then
            echo "${negrita}${rojo}El usuario \"$usuario\" no existe en el sistema. La asignación de usuarios ha sido abortada.${normal}"
            return
        fi
    done

    sudo usermod -aG "$grupo" $usuarios
    echo "${negrita}${verde}Usuarios asignados al grupo: ${normal}$grupo"
}

# Función para crear usuarios leyendo sus nombres de un archivo de texto
function crear_usuarios_desde_archivo() {
    clear
    cabecera "Crear usuarios desde archivo"
    read -p "${negrita}${amarillo}Escribe la ruta del archivo de texto con los nombres de usuario: ${normal}" archivo

    # Verificar si el archivo existe
    if [ ! -f "$archivo" ]; then
        echo "${negrita}${rojo}El archivo \"$archivo\" no existe. La creación de usuarios ha sido abortada.${normal}"
        return
    fi

    while IFS= read -r usuario
    do
        # Verificar si el usuario ya existe en el sistema
        if getent passwd "$usuario" >/dev/null; then
            echo "${negrita}${rojo}El usuario \"$usuario\" ya existe en el sistema. La creación de usuarios ha sido abortada.${normal}"
            return
        fi

        sudo useradd "$usuario"
        echo "${negrita}${verde}Usuario creado: ${normal} $usuario"
    done < "$archivo"

    echo "${negrita}${verde}Creación de usuarios desde archivo completada.${normal}"
}

# Función para mostrar información del sistema
function informacion_sistema() {
    clear
    cabecera "Información del sistema"
    echo ""
    echo "${negrita}${amarillo}- ID del vendedor: ${normal} $(sudo dmidecode -s system-manufacturer)"
    echo ""
    echo "${negrita}${amarillo}- Nombre del modelo: ${normal} $(sudo dmidecode -s system-product-name)"
    echo ""
    # Obtener la frecuencia de la CPU utilizando cat /proc/cpuinfo
    cpu_mhz=$(cat /proc/cpuinfo | grep "cpu MHz" | head -n 1 | awk '{print $4}')
    if [ -z "$cpu_mhz" ]; then
        echo "${negrita}${rojo}- No se pudo obtener la frecuencia de la CPU.${normal}"
    else
        echo "${negrita}${amarillo}- CPU MHz: ${normal} $cpu_mhz"
    fi
    echo ""
    echo "${negrita}${amarillo}- Memoria total: ${normal} $(free -h | grep "Mem" | awk '{print $2}')"
    echo ""
    echo "${negrita}${amarillo}- Memoria libre: ${normal} $(free -h | grep "Mem" | awk '{print $7}')"
    echo ""
    echo "${negrita}${amarillo}- Arquitectura: ${normal} $(uname -m)"
    echo ""
    echo "${negrita}${amarillo}- Versión del kernel: ${normal} $(uname -r)"
}



# Menú principal
while true; do
	clear
    echo "${negrita}${verde}====================================="
    echo "         Menú de Mantenimiento       "
    echo "=====================================${normal}"
    echo "${negrita}${rojo}1.${normal} Listar contenido de un directorio"
    echo "${negrita}${rojo}2.${normal} Crear un fichero"
    echo "${negrita}${rojo}3.${normal} Leer un fichero"
    echo "${negrita}${rojo}4.${normal} Editar un fichero"
    echo "${negrita}${rojo}5.${normal} Copiar un fichero"
    echo "${negrita}${rojo}6.${normal} Mover un fichero"
    echo "${negrita}${rojo}7.${normal} Eliminar ficheros"
    echo "${negrita}${rojo}8.${normal} Mostrar permisos de un fichero o directorio"
    echo "${negrita}${rojo}9.${normal} Instalar un paquete"
    echo "${negrita}${rojo}10.${normal} Matar un proceso"
    echo "${negrita}${rojo}11.${normal} Listar los usuarios del sistema"
    echo "${negrita}${rojo}12.${normal} Crear un usuario"
    echo "${negrita}${rojo}13.${normal} Desactivar un usuario"
    echo "${negrita}${rojo}14.${normal} Eliminar un usuario"
    echo "${negrita}${rojo}15.${normal} Crear un grupo"
	echo "${negrita}${rojo}16.${normal} Listar grupos"
    echo "${negrita}${rojo}17.${normal} Eliminar un grupo"
    echo "${negrita}${rojo}18.${normal} Asignar usuarios a grupos"
    echo "${negrita}${rojo}19.${normal} Crear usuarios desde un archivo"
    echo "${negrita}${rojo}20.${normal} Información del sistema"
    echo "${negrita}${rojo}0.${normal} Salir"
    echo ""
    read -p "${negrita}${amarillo}Selecciona una opción: ${normal}" opcion

    case $opcion in
        1) listar_contenido_directorio ;;
        2) crear_fichero ;;
        3) leer_fichero ;;
        4) editar_fichero ;;
        5) copiar_fichero ;;
        6) mover_fichero ;;
        7) eliminar_ficheros ;;
        8) mostrar_permisos ;;
        9) instalar_paquete ;;
        10) matar_proceso ;;
        11) listar_usuarios ;;
        12) crear_usuario ;;
        13) desactivar_usuario ;;
        14) eliminar_usuario ;;
        15) crear_grupo ;;
		16) listar_grupos ;;
        17) eliminar_grupo ;;
        18) asignar_usuarios_a_grupo ;;
        19) crear_usuarios_desde_archivo ;;
        20) informacion_sistema ;;
        0) echo "${negrita}${azul}Saliendo...${normal}"; exit 0 ;;
        *) echo "${negrita}${rojo}Opción inválida. Intentalo de nuevo.${normal}" ;;
    esac

	echo ""
    echo "${negrita}${amarillo}Pulsa Intro para continuar...${normal}"
    read -r
done
