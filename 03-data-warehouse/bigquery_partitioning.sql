-- Native table: 2,463,900 rows
-- Partitioned (shifted date: sandbox deletes partitions older than 60 days)
CREATE TABLE `dtc-de-course-511820.Zoomcamp.yellow_taxi_partitioned`
PARTITION BY pickup_date_shifted AS
SELECT *, DATE_ADD(DATE(pickup_datetime), INTERVAL 1734 DAY) AS pickup_date_shifted
FROM `dtc-de-course-511820.Zoomcamp.yellow_taxi_native`;

-- Partitioned and clustered
CREATE TABLE `dtc-de-course-511820.Zoomcamp.yellow_taxi_partitioned_clustered`
PARTITION BY pickup_date_shifted
CLUSTER BY vendor_id AS
SELECT *, DATE_ADD(DATE(pickup_datetime), INTERVAL 1734 DAY) AS pickup_date_shifted
FROM `dtc-de-course-511820.Zoomcamp.yellow_taxi_native`;

-- Comparison queries
SELECT DISTINCT vendor_id
FROM `dtc-de-course-511820.Zoomcamp.yellow_taxi_native`
WHERE DATE(pickup_datetime) BETWEEN '2022-01-10' AND '2022-01-20';

SELECT DISTINCT vendor_id
FROM `dtc-de-course-511820.Zoomcamp.yellow_taxi_partitioned`
WHERE pickup_date_shifted BETWEEN '2026-10-10' AND '2026-10-20';

SELECT DISTINCT vendor_id
FROM `dtc-de-course-511820.Zoomcamp.yellow_taxi_partitioned_clustered`
WHERE pickup_date_shifted BETWEEN '2026-10-10' AND '2026-10-20'
  AND vendor_id = '1';
