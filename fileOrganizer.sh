#!/bin/bash
# el script recibe un directorio como parametro y procede a organizarlo
# la orgfanizacion consiste en, crear carpetas con el nombre de la extension del archivo
# y mover alli los archivos
# exit:
# 1: falta proporcionar el directorio
# 2: el directorio no existe

#file extensions
IMGEXT=(JPEG JPG PNG JFIF)
VIDEOEXT=(MP4 WEBM MKV AVI MPEG MPEG-2 MOV)
AUDIOEXT=(MP3 WAV FLAC AIFF WMA)
DIR="/mnt/c/Users/Octavio/Downloads"

if [ ! -e $DIR ]; then
  echo el directorio no existe
  exit 2
fi

cd ${DIR}


# chequea que un valor $1 exista en el array $2
# salida:
# 0: se encuentra
# 1: no se encuentra
containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}



for FILE in *; do
  # pregunta si no es un directorio
  # el script solo ordena archivos, no trabaja con directorios
  if [ ! -d "$FILE" ]; then

    #se obtiene la extension del archivo en mayus
    extension=$(echo ${FILE} | awk -F "." '{print $NF}' | tr -t [:lower:] [:upper:] )

    #va a contener el nombre de la carpeta a donde va a moverse el archivo
    newFolder=$extension
    echo $newFolder

    containsElement "$extension" "${IMGEXT[@]}"
    if [ $? -eq 0 ]; then
      newFolder="IMAGES"
    fi

    containsElement "$extension" "${VIDEOEXT[@]}"
    if [ $? -eq 0 ]; then
      newFolder="VIDEOS"
    fi

    # containsElement "$extension" "${AUDIOEXT[@]}"
    # if [ $? -eq 0 ]; then
    #   newFolder="AUDIO"
    # fi

    if [ ! -d "$newFolder" ]; then

      if [ -e "$newFolder" ]; then
        mv "$newFolder" "_$newFolder"
      fi

      mkdir $newFolder

    fi

    mv "$FILE" "$newFolder"

  fi
done






