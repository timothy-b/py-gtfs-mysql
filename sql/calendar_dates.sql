DROP TABLE IF EXISTS `calendar_dates`;

CREATE TABLE `calendar_dates` (
    service_id INTEGER(10) NOT NULL,
    `date` VARCHAR(8) NOT NULL,
    exception_type TINYINT(1) NOT NULL,

    CHECK (exception_type = 1 || exception_type = 2),

    PRIMARY KEY (service_id, `date`, exception_type),

    FOREIGN KEY (service_id)
      REFERENCES calendar(service_id)
      ON UPDATE CASCADE ON DELETE CASCADE
);
