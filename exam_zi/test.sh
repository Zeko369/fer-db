#!/bin/sh

cd ../exam
./softReset.sh > /dev/null
cd ../exam_zi

psql stream_flix < constraints.sql
psql stream_flix < constraints_test.sql