#!/bin/sh

if [ ! -e "/opt/zou/previews/initialized.txt" ]; then
    echo "initialized.txt not found. init DB and create admin user"
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8

    mkdir -p ${PREVIEW_FOLDER} ${TMP_DIR}

    zou init-db
    zou init-data
    zou create-admin ${ADMIN_USERNAME} --password="${ADMIN_PASSWORD}"

    echo >> "/opt/zou/previews/initialized.txt"
fi