LOAD DATA LOCAL INFILE '~/states.csv' 
INTO TABLE `imbriano`.`State`
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n' 
(`id`, `name`, `abbreviation`) ;
