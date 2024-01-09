-- Dropping database if it exists
DROP DATABASE IF EXISTS olist_stores;

-- Creating the database using character encoding of utf-8
CREATE DATABASE olist_stores DEFAULT CHARACTER SET utf8mb4;

/* uft-8 is a kind of character encoding used to represent 
characters(letters, digits, symbols) as binary numbers.
uft8mb4 is a character encoding that extends the utf-8
encoding to support a larger range of characters including emojis, 
supplementary characters.

I used it in designing this database since I am dealing with internationalization,
diverse character sets to ensure that the database can store and retrieve text data that includes a wide range of character 
*/

-- to check if the database was created
SHOW DATABASES;

-- to make the olist_stores the active database
USE olist_stores;
