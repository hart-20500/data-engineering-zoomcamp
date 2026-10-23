# Module 3 notes: BigQuery partitioning and clustering

- vendor_id is a STRING, so filter with '1'.
- My first partitioned tables were empty: the sandbox deletes partitions older than 60 days and my data is Jan 2022. Fix: shifted date column (+1734 days).
- Bytes processed: native 25.85 MB, partitioned 9.41 MB, clustered 8.12 MB.
- Only 11 of 31 partitions were read (partition pruning), because the filter was on the partition column.
- Clustering gains are small on a small table and grow with table size.
