DROP TABLE IF EXISTS `feed_info`;

CREATE TABLE `feed_info` (
  feed_publisher_name VARCHAR(255) NOT NULL,
  feed_publisher_url VARCHAR(255) NOT NULL,
  feed_lang CHAR(2) NOT NULL,
  feed_start_date VARCHAR(8),
  feed_end_date VARCHAR(8),
  feed_version VARCHAR(255),

  CONSTRAINT uc_feedPub UNIQUE (feed_publisher_name, feed_publisher_url, feed_lang, feed_start_date, feed_end_date, feed_version)
);
