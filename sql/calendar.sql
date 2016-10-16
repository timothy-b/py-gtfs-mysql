DROP TABLE IF EXISTS `calendar`;

CREATE TABLE `calendar` (
  service_id INTEGER(10) PRIMARY KEY,
	monday TINYINT(1) NOT NULL,
	tuesday TINYINT(1) NOT NULL,
	wednesday TINYINT(1) NOT NULL,
	thursday TINYINT(1) NOT NULL,
	friday TINYINT(1) NOT NULL,
	saturday TINYINT(1) NOT NULL,
	sunday TINYINT(1) NOT NULL,
	start_date VARCHAR(8) NOT NULL,
	end_date VARCHAR(8) NOT NULL,
	KEY `service_id` (service_id)
);
