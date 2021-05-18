#!/bin/sh

dropdb --if-exists fer_db_hw_3
createdb fer_db_hw_3

psql fer_db_hw_3 < ./struct.sql

psql fer_db_hw_3 < ./test.sql