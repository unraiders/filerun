# INSTALACIÓN FILERUN EN UNRAID y SYNOLOGY

**Descarga el instalador desde la terminal de Unraid o Synology:**

_wget -O instalar_filerun.sh "https://raw.githubusercontent.com/unraiders/filerun/main/instalar_filerun.sh"_

**Ejecutar:** _chmod +x instalar_filerun.sh_

**Ejecutar:** _./instalar_filerun.sh_

## UNRAID:

Instalamos un contenedor de MariaDB. (aconsejable el de linuxserver/mariadb)

Variables a configurar:

  - Puerto: El puerto de escucha de nuestro servidor de base de datos. (por defecto el 3306)
  - MYSQL_ROOT_PASSWORD: filerun
  - MYSQL_DATABASE: filerun
  - MYSQL_USER: filerun
  - MYSQL_PASSWORD: filerun

El instalador nos ha copiado la carpeta filerun en /mnt/user/appdata (por defecto).

El instalador nos ha copiado la plantilla de filerun en /boot/config/plugins/dockerMan/templates-user.

Para instalar Filerun desde la plantilla vamos a la pestaña Dockers y botón "Agregar Contenedor" seleccionamos el template filerun.

Variables a configurar:

  - FR_DB_HOST: La IP de nuestra base de datos.
  - FR_DB_PORT: El puerto de escucha del servidor de base de datos.

Ruta a configurar:

  - /user-files/: La ruta donde estarán nuestros ficheros de filerun.

Las demás opciones las dejamos por defecto tal como están.


> Si queremos otros datos de conexión de la base de datos los podemos cambiar siempre que sean los mismos en ambos contenedores.


Ahora vamos a la ip_unraid:8686 y tendremos la pantalla de instalación de filerun, siguiente, siguiente, siguiente, fin...


> [!TIP]
> Si en algún momento hemos hecho pruebas o queremos cambiar la ip y/o puerto de la base de datos y nos da error de base de datos en filerun tenemos que eliminar el fichero **autoconfig.php** ubicado en **/mnt/user/appdata/filerun/system/data** (por defecto).


## SYNOLOGY:

Creamos un proyecto nombre filerun (por ejemplo) seleccionamos en /docker/filerun y nos detecta el compose.yaml.

Variables a configurar: (en el compose.yaml)

  -  FR_DB_HOST = IP de nuestro NAS (servidor de la base de datos).
  -  FR_DB_PORT = Puerto de escucha de nuestra base de datos.

  - APACHE_RUN_USER: 
  - APACHE_RUN_USER_ID: 
  - APACHE_RUN_GROUP: 
  - APACHE_RUN_GROUP_ID:

  Estos datos los tenemos con el comando: id <nombre_usuario> desde el terminal del NAS.

Ruta a configurar:

  -  /volume1/filerun-share/

  > [!IMPORTANT]
  > Es importante crear antes la carpeta compartida y que el usuario y el grupo indicado arriba tenga permisos en la carpeta de esta ruta.
  
  
  > Por último si hemos cambiado el puerto de la base de datos (FR_DB_PORT) en el container de filerun tenemos que poner ese puerto en la variable ports: en el primer parámetro del contenedor de la base de datos, abajo del todo del compose. 

> Si queremos otros datos de conexión de la base de datos los podemos cambiar siempre que sean los mismos en ambos contenedores.

Acabamos la instalación del proyecto, vamos a la ip_nas:8686 y tendremos la pantalla de instalación de filerun, siguiente, siguiente, siguiente, fin...

> [!TIP]
> Si en algún momento hemos hecho pruebas o queremos cambiar la ip y/o puerto de la base de datos y nos da error de base de datos en filerun tenemos que eliminar el fichero **autoconfig.php** ubicado en **/volume1/docker/filerun/system/data** (por defecto).

> [!IMPORTANT]
> Could not connect to MySQL server with the provided information.
>  MySQL: SQLSTATE[HY000] [2006] MySQL server has gone away
>
> Si después de la instalación te aparece este mensaje es normal, Synology no se le conoce por tener un hardware muy potente y requiere de su tiempo para levantar el servidor de base de datos por primera vez, dale 10 segundos de rigor.  


> [!TIP]
> Si queremos tener la interface de Filerun en Español tenemos que descargar el fichero **spanish.php** y subirlo a nuestra carpeta de filerun en la siguiente ruta **/system/data/translations/** y después activarlo "Control panel" -> Interface.
> 

### FIN
  

