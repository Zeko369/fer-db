#!/bin/sh

dropdb stream_flix --if-exists
createdb stream_flix
psql stream_flix < ./StreamFlix.sql
