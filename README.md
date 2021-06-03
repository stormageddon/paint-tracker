

### Run postgres locally
If init.sql has been updated:
1. Remove containers and image of this app 
2. docker build . -t paint_postgres:latest
3. docker run -e POSTGRES_PASSWORD=password -p 30432:5432 paint_postgres

If init.sql has not been updated:
1. docker volume rm data_volume
2. docker run -e POSTGRES_PASSWORD=password -p 30432:5432 paint_postgres
