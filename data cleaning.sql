CREATE TABLE bike_share_year_0 (
dteday TEXT,
season INT,
yr INT,	
mnth INT,	
hr INT,	
holiday INT,	
weekday INT,
workingday INT,	
weathersit INT,	
temp DOUBLE,	
atemp DOUBLE,	
hum DOUBLE,	
windspeed INT,	
rider_type TEXT,	
riders INT
);

USE bike_data;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/bike_share_yr_0.csv' INTO TABLE bike_share_year_0
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

CREATE TABLE bike_share_year_1 (
dteday TEXT,
season INT,
yr INT,	
mnth INT,	
hr INT,	
holiday INT,	
weekday INT,
workingday INT,	
weathersit INT,	
temp DOUBLE,	
atemp DOUBLE,	
hum DOUBLE,	
windspeed INT,	
rider_type TEXT,	
riders INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/bike_share_yr_1.csv' INTO TABLE  bike_share_year_1
FIELDS TERMINATED BY ','
IGNORE 1 LINES;

WITH cte AS (
SELECT * FROM bike_share_year_0
UNION ALL
SELECT * FROM bike_share_year_1
)
SELECT * FROM cte a
LEFT JOIN cost_table b
ON a.yr = b.yr;

CREATE OR REPLACE VIEW v_bike_data_combined AS
SELECT * FROM bike_share_year_0
UNION ALL
SELECT * FROM bike_share_year_1;

CREATE OR REPLACE VIEW v_bike_financial_results AS
SELECT 
    a.dteday,
    a.season,
    a.yr,
    a.hr,
    a.weekday,
    a.rider_type,
    a.riders,
    b.price,
    b.COGS,
    riders*price AS revenue,
    (riders*price) - (riders*COGS) AS profit
FROM v_bike_data_combined a
LEFT JOIN cost_table b
ON a.yr = b.yr;

