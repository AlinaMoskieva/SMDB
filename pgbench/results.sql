-- initialize pgbench
pgbench -i SMDB

-- test
pgbench SMDB

transaction type: <builtin: TPC-B (sort of)>
scaling factor: 1
query mode: simple
number of clients: 1
number of threads: 1
number of transactions per client: 10
number of transactions actually processed: 10/10

latency average = 2.250 ms
tps = 444.357331 (including connections establishing)
tps = 535.415342 (excluding connections establishing)

-- test with duration = 120
pgbench -T 120 SMDB

starting vacuum...end.
transaction type: <builtin: TPC-B (sort of)>
scaling factor: 1
query mode: simple
number of clients: 1
number of threads: 1
duration: 120 s
number of transactions actually processed: 110045

latency average = 1.090 ms
tps = 917.032058 (including connections establishing)
tps = 917.075134 (excluding connections establishing)


pgbench -T 300 -l -f /Users/moskieva/University/SMDB/pgbench/bench_test_for_fts.sql SMDB
starting vacuum...end.
transaction type: /Users/moskieva/University/SMDB/pgbench/bench_test_for_fts.sql
scaling factor: 1
query mode: simple
number of clients: 1
number of threads: 1
duration: 300 s
number of transactions actually processed: 1043420
latency average = 0.288 ms
tps = 3478.049468 (including connections establishing)
tps = 3478.098498 (excluding connections establishing)


