-- Module 3: BigQuery best practices and cost tests

-- 1. Native table: one month of 2022 yellow taxi data
CREATE OR REPLACE TABLE `dtc-de-course-511820.zoomcamp.yellow_tripdata` AS
SELECT vendor_id, pickup_datetime, dropoff_datetime, passenger_count,
       trip_distance, payment_type, fare_amount, tip_amount, total_amount
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
WHERE pickup_datetime >= '2022-01-01' AND pickup_datetime < '2022-02-01';

-- 2. Partitioned table (by pickup date)
CREATE OR REPLACE TABLE `dtc-de-course-511820.zoomcamp.yellow_tripdata_partitioned`
PARTITION BY DATE(pickup_datetime) AS
SELECT * FROM `dtc-de-course-511820.zoomcamp.yellow_tripdata`;

-- 3. Partitioned and clustered table
CREATE OR REPLACE TABLE `dtc-de-course-511820.zoomcamp.yellow_tripdata_clustered`
PARTITION BY DATE(pickup_datetime)
CLUSTER BY payment_type AS
SELECT * FROM `dtc-de-course-511820.zoomcamp.yellow_tripdata`;

-- 4. Select all columns: reads more bytes
SELECT * FROM `dtc-de-course-511820.zoomcamp.yellow_tripdata_partitioned` LIMIT 10;

-- 5. Select only two columns: reads far fewer bytes
SELECT pickup_datetime, total_amount
FROM `dtc-de-course-511820.zoomcamp.yellow_tripdata_partitioned` LIMIT 10;

-- 6. Filter on the partition column: native vs partitioned
SELECT COUNT(*) FROM `dtc-de-course-511820.zoomcamp.yellow_tripdata`
WHERE pickup_datetime >= '2022-01-15' AND pickup_datetime < '2022-01-16';

SELECT COUNT(*) FROM `dtc-de-course-511820.zoomcamp.yellow_tripdata_partitioned`
WHERE pickup_datetime >= '2022-01-15' AND pickup_datetime < '2022-01-16';