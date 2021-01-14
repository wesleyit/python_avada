ifndef VERBOSE
MAKEFLAGS += --no-print-directory
endif
SHELL := /bin/bash
TEST_PATH=./
.DEFAULT_GOAL := help


help:
	@ echo "Use one of the following targets:"
	@ tail -n +8 Makefile |\
	egrep "^[a-z]+[\ :]" |\
	tr -d : |\
	tr " " "/" |\
	sed "s/^/ - /g"
	@ echo "Read the Makefile for further details"

venv:
	@ echo "Creating a new virtualenv..."
	@ rm -rf env || true
	@ python3 -m venv env
	@ echo "Done, now you need to activate it. Run:"
	@ echo "source env/bin/activate"

pip:
	@ if [ -z "${VIRTUAL_ENV}" ]; then \
		echo "Not inside a virtualenv."; \
		exit 1; \
	fi
	@ echo "Upgrading pip..."
	@ pip install --upgrade pip
	@ echo "Updating pip packages:"
	@ pip install -r "requirements.txt"

reset:
	@ echo "Removing db, env, and cache..."
	@ rm -rf .pytest_cache
	@ rm -rf .tox
	@ rm -rf dist
	@ rm -rf build
	@ rm -rf tests/__pycache__
	@ rm -rf *.egg-info
	@ rm -rf env
	@ sudo rm -rf db
	@ echo "All done!"

clean:
	@ echo "Cleaning cache..."
	@ rm -rf .pytest_cache
	@ rm -rf .tox
	@ rm -rf dist
	@ rm -rf build
	@ rm -rf tests/__pycache__
	@ rm -rf *.egg-info
	@ echo "All done!"

lint:
	@ echo "Running flake8 and isort..."
	@ flake8 --exclude=.tox
	@ isort --skip-glob=.tox --recursive .
	@ echo "All done!"

start:
	@ echo "Starting the app..."
	@ python app.py ${DBSTRING}

build:
	@ echo "Building Docker image..."
	@ docker build --rm -t python_ava:latest .
	@ echo "All done!"

runapp:
	@ echo "Running the app container..."
	@ docker rm -f python_ava || true
	@ docker run --rm \
		--name python_ava \
		-p 8080:8080 \
		-e DBSTRING=$(DBSTRING) \
		-d python_ava:latest

rundb:
	@ echo "Running the db container..."
	@ mkdir -p db
	@ docker rm -f mysql || true
	@ docker run --rm \
		--name mysql \
		-e MYSQL_ROOT_PASSWORD=RootPW123 \
		-e MYSQL_USER=avada \
		-e MYSQL_PASSWORD=kedavra123 \
		-e MYSQL_DATABASE=avada_db \
		-v $(pwd)/db:/var/lib/mysql \
		-p 3306:3306 \
		-d mysql
	@ docker ps -a | grep mysql

initdb:
	@ sleep 5
	@ docker exec -i mysql \
		mysql -uavada -pkedavra123 avada_db \
		< db_seed/avada_db_dump.sql

backupdb:
	@ docker exec -i mysql \
		mysqldump -uavada -pkedavra123 avada_db \
		> db_dump_$(date +%d-%m-%Y %H %M %S).sql
