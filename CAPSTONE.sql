
#creating a database
create database Olympics_db;

#using the database
use Olympics_db;


#creating the main table which has all details of raw data.
CREATE TABLE `main` (
  `name` varchar(100) DEFAULT NULL,
  `age` varchar(3) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `Date_Given` varchar(20) DEFAULT NULL,
  `sports` varchar(30) DEFAULT NULL,
  `gold_medal` int DEFAULT NULL,
  `silver_medal` int DEFAULT NULL,
  `brone_medal` int DEFAULT NULL,
  `total_medal` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


#insert statement
INSERT INTO `olympics_db`.`main`
(`name`,
`age`,
`country`,
`year`,
`Date_Given`,
`sports`,
`gold_medal`,
`silver_medal`,
`brone_medal`,
`total_medal`)
VALUES
(<{name: }>,
<{age: }>,
<{country: }>,
<{year: }>,
<{Date_Given: }>,
<{sports: }>,
<{gold_medal: }>,
<{silver_medal: }>,
<{brone_medal: }>,
<{total_medal: }>);


#loading the csv file for main table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olympix_data_organized_with_header (2).csv'
INTO TABLE main
FIELDS TERMINATED BY ','
LINES terminated by '\n'
IGNORE 1 ROWS;

#getting count of main table
select count(*) from main;

#creating player demography table with the attributes of player id, name, birth year, country
CREATE TABLE `player_demo` (
  `player_id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
   country varchar(100),
   birth_year int not null,
  PRIMARY KEY (`player_id`));
  
#loading csv data in player demo table.
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\player_Demo2.csv'
INTO TABLE player_demo
FIELDS TERMINATED BY ','
LINES terminated by '\n'
IGNORE 1 ROWS;

#selecting all values of player demo table
select * from player_demo;

#creating table for sports with the variable, sports_id, sports name
CREATE TABLE `sports` (
  `sports_id` varchar(3) NOT NULL,
  `Sport_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`sports_id`));

#inserting values on sports table
INSERT INTO `olympics_db`.`sports`
(`sports_id`,
`Sport_name`)
VALUES
(<{sports_id: }>,
<{Sport_name: }>);

#loading data from csv file to sports table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\sports.csv'
INTO TABLE sports
FIELDS TERMINATED BY ','
LINES terminated by '\n'
IGNORE 1 ROWS;

#getting count of sports table
select count(*) from sports;

#creating table for olympics with the attributes of olympic id, year
CREATE TABLE `olympics` (
  `olympix_id` int NOT NULL,
  `Year` int,
  PRIMARY KEY (`olympix_id`));
  
INSERT INTO `olympics_db`.`olympics`
(`olympix_id`,
`Year`)
VALUES
(<{olympix_id: }>,
<{Year: }>);


#selecting the variables which has been uploading using pymysql
select * from olympics_db.olympix_data_organized_new_firsthere;

INSERT INTO `olympics_db`.`olympix_data_organized_new_firsthere`
(`index`,
`name`,
`age`,
`country`,
`year`,
`Date_Given`,
`sports`,
`gold_medal`,
`silver_medal`,
`brone_medal`,
`total_medal`)
VALUES
(<{index: }>,
<{name: }>,
<{age: }>,
<{country: }>,
<{year: }>,
<{Date_Given: }>,
<{sports: }>,
<{gold_medal: }>,
<{silver_medal: }>,
<{brone_medal: }>,
<{total_medal: }>);

#loading Olympics csv file to olympics table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\olympix2.csv'
INTO TABLE olympics
FIELDS TERMINATED BY ','
LINES terminated by '\n'
IGNORE 1 ROWS;

select * from olympics;

#creating the final table for events with the atributes name all id, player_id, sports_id, gold medal, silver medal, total medal and dtae given
create table events(
all_id int primary key not null,
player_id int,
olympix_id int,
date_given varchar(30),
sports_id varchar(50),
gold_medal int not null,
silver_medal  int not null,
brone_medal  int not null,
total_medal  int not null);

#inserting values at events table
INSERT INTO `olympics_db`.`events`
(`all_id`,
`player_id`,
`olympix_id`,
`date_given`,
`sports_id`,
`gold_medal`,
`silver_medal`,
`brone_medal`,
`total_medal`)
VALUES
(<{all_id: }>,
<{player_id: }>,
<{olympix_id: }>,
<{date_given: }>,
<{sports_id: }>,
<{gold_medal: }>,
<{silver_medal: }>,
<{brone_medal: }>,
<{total_medal: }>);


SET GLOBAL FOREIGN_KEY_CHECKS=0;
alter table events
add FOREIGN KEY (sports_id) REFERENCES Sports(sports_id) ,
add FOREIGN KEY (olympix_id) REFERENCES olympics(olympix_id) ,
add FOREIGN KEY (player_id) REFERENCES Player_demo(player_id);


#loading data in ecvents table
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\all data.csv'
INTO TABLE events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


##QUERIES:--


#Find the average number of medals won by each country

/*fetching country and average of total medals and rounding it off  from main table,
grouping by country*/

select country, round(avg(total_medal)) as avg_medal from main
group by country
order by avg_medal desc;

#or 

/*fetching country, average from events table by joining player_id from events and player_Demo table */
select player_demo.country, round(avg(total_medal)) as avg_medal from events
inner join player_demo
on player_demo.player_id = events.player_id
group by country
order by avg_medal desc;

#task2 :- Display the countries and the number of gold medals they have won in decreasing order

/*fetching country and using aggeragate function count to get number of gold medal,
grouping by country and ordering in descending order from main table*/

select country, count(gold_medal) from main
group by country
order by count(gold_medal) desc;

#OR

/*fetching country, count of gold medals from events table by joining player_id from events and player_Demo table */

select player_demo.country, count(gold_medal) from events
inner join player_demo
on player_demo.player_id = events.player_id
group by country
order by count(gold_medal) desc;

#Task 3 :- Display the list of people and the medals they have won in descending order, grouped by their country

/* fetching name, country and sum of total medals from main table,
grouping by name and country,
ordering by total medals in descending order */

select name,country,  sum(total_medal) from main
group by name,country
order by sum(total_medal) desc;

#OR

#fetching name,country, sum of total medals from events table by joining player demo table.
select name,country, sum(total_medal) from events
inner join player_demo
on player_demo.player_id = events.player_id
group by name,country
order by sum(total_medal) desc;


#Task 4 :- Display the list of people with the medals they have won according to their age

#fetching name, age and medals details from main table, ordering by age.

select name, age, gold_medal, silver_medal, brone_medal, total_medal from main
order by age desc;

# Task 5 :-Which country has won the most number of medals (cumulative)

/*fetching country, sum of total medals from main table, grouping by country and ordering by total medal and limiting the answer to one.
select country,sum(total_medal) as total  from main
group by country 
order by total_medal desc
limit 1;
