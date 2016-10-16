DROP TABLE IF EXISTS `frequencies`;

CREATE TABLE `frequencies` (
  trip_id INTEGER(10) NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  headway_secs INTEGER(5) UNSIGNED NOT NULL,
  exact_times TINYINT(1) DEFAULT 0,

  CHECK (exact_times = 0 || exact_times = 1),

  FOREIGN KEY (trip_id)
    REFERENCES trips(trip_id)
    ON UPDATE CASCADE ON DELETE CASCADE,

  CONSTRAINT uc_tripFreq UNIQUE (trip_id, start_time, end_time)
);
