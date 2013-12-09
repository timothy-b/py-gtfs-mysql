DROP TABLE IF EXISTS `calendar_dates`;

CREATE TABLE `calendar_dates` (
    `date` VARCHAR(8),
    exception_type INT(2),
	service_id VARCHAR(10),
    KEY `date` (date),
    KEY `service_id` (service_id),
    KEY `exception_type` (exception_type)    
);
