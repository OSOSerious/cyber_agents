$env:PGUSER = "postgres"
$env:PGPASSWORD = "password"

# Create the database
psql -c "CREATE DATABASE contacting_ai_dev;"

Write-Host "Database created successfully!"
