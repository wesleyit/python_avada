# README

```bash
# Clean everything
deactivate
make reset

# Create a new env
make venv
source env/bin/activate

# Install the deps
make pip

# Build the app container image
make build

# Run the database container
make rundb

# Run the application container
export DB_IP="$(docker inspect --format '{{.NetworkSettings.IPAddress}}' mysql)"
make runapp DBSTRING="mysql+pymysql://avada:kedavra123@${DB_IP}/avada_db"

# Load data into DB
make initdb

# Finished
echo 'Done!'

```

Or simply run:

`./run_all.sh`
