#!/bin/sh

dropdb --if-exists fer_db_lab_2 && createdb fer_db_lab_2

psql fer_db_lab_2 < ./BirackoMjesto.sql

psql fer_db_lab_2  < ./test.sql
