-- Create User Table
CREATE TABLE user_table (
    userId VARCHAR(20) PRIMARY KEY,
    name VARCHAR(50),
    emailAddress VARCHAR(100)
);

-- Insert data into User table
INSERT ALL
    INTO user_table (userId, name, emailAddress) VALUES ('simon3', 'Simon, S', 'simon3@hotmail.co.uk')
    INTO user_table (userId, name, emailAddress) VALUES ('talia11', 'Talia, J', 'talia11@ntl.co.uk')
    INTO user_table (userId, name, emailAddress) VALUES ('toby05', 'Toby, T', 'toby05@freeserve.co.uk')
    INTO user_table (userId, name, emailAddress) VALUES ('margot9', 'Margot, C', 'margot9@msn.co.uk')
    INTO user_table (userId, name, emailAddress) VALUES ('ethan77', 'Ethan, R', 'ethan77@hotmail.co.uk')
    INTO user_table (userId, name, emailAddress) VALUES ('nancy91', 'Nancy, L', 'nancy91@tesco.co.uk')
SELECT * FROM dual;

SELECT * FROM user_table;



-- Create Movie Table
CREATE TABLE Movie (
    movieId VARCHAR(20) PRIMARY KEY,
    title VARCHAR(100),
    categoryCode VARCHAR(5),
    costPerDownload DECIMAL(5,2)
);
INSERT ALL
    INTO Movie (movieId, title, categoryCode, costPerDownload) VALUES ('M001', 'The Imitation Game', 'MO13', 0.99)
    INTO Movie (movieId, title, categoryCode, costPerDownload) VALUES ('M002', 'The Duchess', 'MO13', 1.99)
    INTO Movie (movieId, title, categoryCode, costPerDownload) VALUES ('M003', 'Trainspotting', 'MO11', 1.49)
    INTO Movie (movieId, title, categoryCode, costPerDownload) VALUES ('M004', 'The Dig', 'MO11', 1.79)
    INTO Movie (movieId, title, categoryCode, costPerDownload) VALUES ('M005', 'Elizabeth', 'MO13', 1.50)
    INTO Movie (movieId, title, categoryCode, costPerDownload) VALUES ('M006', 'Sherlock Holmes', 'MO12', 1.10)
    INTO Movie (movieId, title, categoryCode, costPerDownload) VALUES ('M007', 'Moon', 'MO12', 0.89)
SELECT * FROM dual;
SELECT * FROM Movie;


-- Create DownloadMovie Table
CREATE TABLE DownloadMovie (
    userId VARCHAR(20),
    movieId VARCHAR(20),
    downloadDate DATE,
    PRIMARY KEY (userId, movieId),
    FOREIGN KEY (userId) REFERENCES user_table(userId),
    FOREIGN KEY (movieId) REFERENCES Movie(movieId)
);
INSERT ALL
    INTO DownloadMovie (userId, movieId, downloadDate) VALUES ('simon3', 'M002', TO_DATE('03-May-2021', 'DD-Mon-YYYY'))
    INTO DownloadMovie (userId, movieId, downloadDate) VALUES ('margot9', 'M005', TO_DATE('01-May-2022', 'DD-Mon-YYYY'))
    INTO DownloadMovie (userId, movieId, downloadDate) VALUES ('talia11', 'M002', TO_DATE('06-May-2021', 'DD-Mon-YYYY'))
    INTO DownloadMovie (userId, movieId, downloadDate) VALUES ('margot9', 'M001', TO_DATE('06-May-2022', 'DD-Mon-YYYY'))
    INTO DownloadMovie (userId, movieId, downloadDate) VALUES ('simon3', 'M003', TO_DATE('01-Aug-2022', 'DD-Mon-YYYY'))
    INTO DownloadMovie (userId, movieId, downloadDate) VALUES ('ethan77', 'M004', TO_DATE('02-Aug-2022', 'DD-Mon-YYYY'))
    INTO DownloadMovie (userId, movieId, downloadDate) VALUES ('nancy91', 'M007', TO_DATE('05-Sep-2021', 'DD-Mon-YYYY'))
SELECT * FROM dual;
SELECT * FROM DOWNLOADMOVIE;

-- Create Category Table
CREATE TABLE Category_table (
    categoryCode VARCHAR(5) PRIMARY KEY,
    title VARCHAR(50)
);

INSERT ALL
    INTO Category_table (categoryCode, title) VALUES ('MO11', 'Drama')
    INTO Category_table (categoryCode, title) VALUES ('MO12', 'Fiction')
    INTO Category_table (categoryCode, title) VALUES ('MO13', 'Biopic')
SELECT * FROM dual;
SELECT * FROM Category_table;


--2a  
SELECT movieId, title, categoryCode
FROM Movie
ORDER BY title;

-- 2b
SELECT COUNT(DISTINCT dm.userId) AS numUsersDownloadedPopRock
FROM DownloadMovie dm
JOIN Movie m ON dm.movieId = m.movieId
JOIN Category_table c ON m.categoryCode = c.categoryCode
WHERE c.title = 'Pop-Rock';

-- 2c
SELECT c.title AS categoryTitle, COUNT(dm.userId) AS numDownloads
FROM DownloadMovie dm
JOIN Movie m ON dm.movieId = m.movieId
JOIN Category_table c ON m.categoryCode = c.categoryCode
GROUP BY c.title;


-- 2d
SELECT c.title AS categoryTitle
FROM Category_table c
JOIN Movie m ON c.categoryCode = m.categoryCode
JOIN DownloadMovie dm ON m.movieId = dm.movieId
GROUP BY c.title
HAVING COUNT(dm.userId) > 1;



-- Create the "orders" table
CREATE TABLE orders (
    orders_item_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    OrderNo NUMBER(5),
    ProductNo NUMBER(10),
    Price NUMBER(10,2),
    Quantity NUMBER(5),
    Sales NUMBER(10,2),
    QtrId NUMBER(1),
    MonthId NUMBER(2),
    YearId NUMBER(4)
);
-- Insert into orders
INSERT INTO orders (OrderNo, ProductNo, Price, Quantity, Sales, QtrId, MonthId, YearId) VALUES (10107, 2, 85.7, 30, 2587, 1, 2, 2003);
INSERT INTO orders (OrderNo, ProductNo, Price, Quantity, Sales, QtrId, MonthId, YearId) VALUES (10108, 5, 95.8, 39, 3879.49, 1, 2, 2003);
INSERT INTO orders (OrderNo, ProductNo, Price, Quantity, Sales, QtrId, MonthId, YearId) VALUES (10109, 5, 71.5, 34, 2700, 1, 2, 2003);
INSERT INTO orders (OrderNo, ProductNo, Price, Quantity, Sales, QtrId, MonthId, YearId) VALUES (10110, 2, 94.74, 41, 3884.34, 3, 7, 2004);
INSERT INTO orders (OrderNo, ProductNo, Price, Quantity, Sales, QtrId, MonthId, YearId) VALUES (10111, 5, 100, 27, 3307.77, 3, 7, 2004);
INSERT INTO orders (OrderNo, ProductNo, Price, Quantity, Sales, QtrId, MonthId, YearId) VALUES (10112, 14, 100, 49, 5205.27, 4, 10, 2005);
INSERT INTO orders (OrderNo, ProductNo, Price, Quantity, Sales, QtrId, MonthId, YearId) VALUES (10113, 1, 96.66, 36, 3479.66, 4, 10, 2006);
INSERT INTO orders (OrderNo, ProductNo, Price, Quantity, Sales, QtrId, MonthId, YearId) VALUES (10114, 12, 100, 42, 4695.6, 4, 11, 2006);
SELECT * FROM orders;

--C1
SELECT
    ProductNo,
    YearId,
    MonthId,
    COUNT(*) AS NumProductsSold
FROM
    orders
GROUP BY
    ProductNo, YearId, MonthId
ORDER BY
    ProductNo, YearId, MonthId ASC;



























