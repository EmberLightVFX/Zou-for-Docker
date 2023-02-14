#!/bin/sh

if [ ! -e "/opt/zou/previews/initialized.txt" ]; then
    echo "initialized.txt not found. init DB and create admin user 'admin@example.com' with password 'mysecretpassword'"
    export LC_ALL=C.UTF-8
    export LANG=C.UTF-8

    mkdir -p ${PREVIEW_FOLDER} ${TMP_DIR}

    zou init-db
    zou init-data
    zou create-admin admin@example.com --password=mysecretpassword

    echo >> "/opt/zou/previews/initialized.txt"
fi