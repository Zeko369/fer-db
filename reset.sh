#!/bin/sh

dropdb stud_admin --if-exists
createdb stud_admin
psql stud_admin < ./studAdmin.sql