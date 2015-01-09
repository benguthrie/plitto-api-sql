cd c:\xampp\mysql\bin
mysqldump --routines --no-create-info --no-data --no-create-db --skip-opt plitto2014 --user=root > c:\xampp\htdocs\plitto-api-sql\routines.sql
mysqldump plitto2014 --user=root --no-data --tab=c:\xampp\htdocs\plitto-api-sql 