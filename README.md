# Script de mantenimiento creado con bash

Este es un pequeño script en bash para realizar operaciones básicas de mantenimiento en equipo con LinuX.

![menu-mantenimiento-bash](https://github.com/sapoclay/mantenimiento-bash/assets/6242827/980ea2cd-8964-4845-af27-b6ed21482433)

Vamos a crear un script bash de mantenimiento con las siguientes funciones mediante la interacción del usario que permita;
- Seleccionar un directorio para listar su contenido
- Crear un fichero en un directorio que seleccione el usuario. Indicando también el nombre
- Leer un fichero que indique el usuario
- Editar un fichero. En caso de que no exista se muestra un error
- Copiar un fichero indicado por el usuario de un directorio a otro
- Mover un fichero indicado por el usuario de un directorio a otro
- Eliminar ficheros indicados por el usuario
- Mostrar permisos de un fichero o directorio concreto
- Instalar un paquete determinado (primero hay que buscarlo en los repositorios, y si el paquete existe se instala, sino se muestra un error)
- Matar un proceso seleccionado por el usuario
- Listar los usuarios del sistema
- Crear un usuario
- Desactivar un usuario
- Eliminar un usuario
- Crear un grupo
- Listar los usuarios del sistema
- Eliminar un grupo
- Asignar usuarios a grupos
- Crear usuarios leyendo sus nombres de un archivo de texto. El archivo de texto debe ser indicado por el usuario
- Mostrar información del sistema con la siguiente salida:
    * Id del vendedor
    * Nombre del modelo
    * CPU MHZ
    * Memoria total
    * Memoria libre
    * Arquitectura
    * Versión del kernel

## USO
Una vez descargado el archivo mantenimiento.sh, en una terminal solo hay que escribir:
``chmod +x mantenimiento.sh``
Después para ejecutar el archivo, en la misma terminal, y desde la carpeta en la que tengamos guardado el archivo, basta con escribir:
``./mantenimiento.sh``
