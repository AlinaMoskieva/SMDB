#!/bin/bash
echo "Bench test"

bash -c "pgbench -T 600 -l -f /Users/moskieva/University/SMDB/pgbench/bench_test_for_fts.sql SMDB"  > time.csv