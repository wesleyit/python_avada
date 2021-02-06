#!/bin/bash

## The workdir must be the project root
cd "$(dirname $0)"
WORK_DIR="$(pwd)"

function help() {
    HELP=" help: Displays this help message."
    echo ""
    echo -e "Usage: $0 [option]\n"
    echo -e "Accepted options are:\n"
    cat "$0" |
        grep -v grep |
        grep HELP |
        cut -d \" -f 2
    echo ""
}

function venv() {
    HELP=" venv: Creates and activate the Virtual Environment for Python."
    deactivate 2>/dev/null || true
    rm -rf env 2>/dev/null || true
    python3 -m venv env
    source "env/bin/activate"
    pip install -U -r "./application/requirements.txt"
}

function build() {
    HELP=" build: Generates the latest tag of the application Docker image."
    cd "application/"
    docker build --rm -t wesleyit/python_ava:latest .
    cd ..
}

function run_app() {
    HELP=" run_app: Executes the application using Python"
    [ -z "$DBSTRING" ] && echo "Export the DBSTRING variable." && exit 1
    source "env/bin/activate"
    cd "application/"
    while true; do
        python app.py "$DBSTRING"
    done
    cd ..
}

function run_app_container() {
    HELP=" run_app_container: Executes the application using Docker."
    [ -z "$DBSTRING" ] && echo "Export the DBSTRING variable." && exit 1
    docker rm -f python_ava 2>/dev/null || true
    docker run --rm \
        --name python_ava \
        -p "8080:8080" \
        -e DBSTRING="${DBSTRING}" \
        -d wesleyit/python_ava:latest
}

function run_db_container() {
    HELP=" run_db_container: Executes the database using Docker."
    mkdir -p "database/db_volume"
    docker rm -f mysql 2>/dev/null || true
    docker run --rm \
        --name mysql \
        -e MYSQL_ROOT_PASSWORD="RootPW123" \
        -e MYSQL_USER="avada" \
        -e MYSQL_PASSWORD="kedavra123" \
        -e MYSQL_DATABASE="avada_db" \
        -v "$(pwd)/database/db_volume:/var/lib/mysql:rw" \
        -p "3306:3306" \
        -d mysql
    sleep 2
    export DB_IP="$(docker inspect --format '{{.NetworkSettings.IPAddress}}' mysql)"
    export DBSTRING="mysql+pymysql://avada:kedavra123@${DB_IP}/avada_db"
}

function load_db_container() {
    HELP=" load_db_container: Creates the app tables on the Docker container."
    echo "Waiting for MySQL to be ready..."
    docker exec -i mysql \
        mysql -uavada -pkedavra123 avada_db \
        <database/db_seed/avada_db_dump.sql
    echo "show tables;" | docker exec -i mysql \
        mysql -uavada -pkedavra123 avada_db
}

function backup_db() {
    HELP=" backup_db: Creates a MySQL dump of the container."
    mysqldump -uavada -pkedavra123 avada_db \
        >db_dump_$(date +%d-%m-%Y %H %M %S).sql
}

function all() {
    HELP=" all: Does everithing to run the application with Docker."
    deactivate 2>/dev/null || true
    sudo rm -rf env 2>/dev/null || true
    docker rm -f python_ava 2>/dev/null || true
    docker rm -f mysql 2>/dev/null || true
    sudo rm -rf "database/db_volume" || true
    run_db_container
    build
    sleep 10 && load_db_container
    run_app_container
}

case $1 in
venv) venv && exec "$SHELL" ;;
build) build ;;
run_app) run_app ;;
run_app_container) run_app_container ;;
run_db_container) run_db_container && exec "$SHELL" ;;
load_db_container) load_db_container ;;
all) all ;;
backup_db) backup_db ;;
*) help ;;
esac
