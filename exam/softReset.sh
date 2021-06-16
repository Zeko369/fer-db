#!/bin/sh

psql < ./disconnect.sql

dropdb stream_flix --if-exists
createdb stream_flix
psql stream_flix < ./StreamFlix.dump
