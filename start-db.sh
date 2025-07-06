#!/bin/bash

# Load environment variables
source .env

# Start PostgreSQL service (assuming PostgreSQL is installed locally)
echo "Starting PostgreSQL database service..."

# Create database if it doesn't exist
createdb -h $DB_HOST -p $DB_PORT -U postgres $DB_NAME 2>/dev/null || true

# Create user if it doesn't exist
psql -h $DB_HOST -p $DB_PORT -U postgres -c "CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';" 2>/dev/null || true

# Grant privileges
psql -h $DB_HOST -p $DB_PORT -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;" 2>/dev/null || true

# Run schema and initialization
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f schema.sql
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f init.sql

echo "Database service started on port $DB_PORT"