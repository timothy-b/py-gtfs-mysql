DROP TABLE IF EXISTS `transfers`;

CREATE TABLE `transfers` (
  from_stop_id VARCHAR(10) NOT NULL,
  to_stop_id VARCHAR(10) NOT NULL,
  transfer_type TINYINT(1) DEFAULT 0,
  min_transfer_time INTEGER(5) UNSIGNED,
  CHECK (transfer_type >= 0 && transfer_type <= 3),

  FOREIGN KEY (from_stop_id)
    REFERENCES stops(stop_id)
    ON UPDATE CASCADE ON DELETE CASCADE,

  FOREIGN KEY (to_stop_id)
    REFERENCES stops(stop_id)
    ON UPDATE CASCADE ON DELETE CASCADE
);
