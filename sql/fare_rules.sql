DROP TABLE IF EXISTS `fare_rules`;

CREATE TABLE `fare_rules` (
  fare_id VARCHAR(255) NOT NULL,
  route_id VARCHAR(10),
  origin_id VARCHAR(10),
  destination_id VARCHAR(10),
  contains_id VARCHAR(10),

  FOREIGN KEY (fare_id)
    REFERENCES fare_attributes(fare_id)
    ON UPDATE CASCADE ON DELETE CASCADE
);
