DROP TABLE IF EXISTS `agency`;

CREATE TABLE `agency` (
    agency_id VARCHAR(10) PRIMARY KEY,
    agency_name VARCHAR(255) NOT NULL,
    agency_url VARCHAR(255) NOT NULL,
    agency_timezone VARCHAR(50) NOT NULL,
    agency_lang CHAR(2),
    agency_phone VARCHAR(32),
    agency_fare_url VARCHAR(255),
    agency_email VARCHAR(255)
);
