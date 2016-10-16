DROP TABLE IF EXISTS `fare_attributes`;

CREATE TABLE `fare_attributes` (
  fare_id VARCHAR(255) PRIMARY KEY,
  price DECIMAL (4,2) NOT NULL,
  currency_type VARCHAR(3) NOT NULL,
  payment_method TINYINT(1) NOT NULL,
  transfers TINYINT(1) NOT NULL,
  transfer_duration INTEGER(5) UNSIGNED,

  CHECK (payment_method = 0 || payment_method = 1),
  CHECK (transfers >= 0 && transfers <= 2)
);
