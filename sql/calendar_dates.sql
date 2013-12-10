DROP TABLE IF EXISTS `calendar_dates`;

CREATE TABLE `calendar_dates` (
    `date` VARCHAR(8),
	date_timestamp INT(11),
    exception_type INT(2),
	service_id VARCHAR(10),
    KEY `service_id` (service_id),
    KEY `date_timestamp` (date),
    KEY `exception_type` (exception_type)    
);
