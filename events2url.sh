#!/usr/bin/env bash

# This script is expecting an input file name in the format of:
# feed\t event-type\t (Factory|V2)
# You can copy the first three columns (minue header!) from: https://docs.google.com/spreadsheets/d/1ps6f17tO2Crl54twgQGEdLnSwcojmxxxKmLsE4ZE8VM/edit#gid=1445581676


input_file=$1

#Sample Factory: http://azkaban-dr.gdp.data.grubhub.com/manager?project=gdp_streaming_ingestion_events_courierattendance&flow=ingest_courier_penalty_payload#executions
#Sample V2: http://azkaban-dr.gdp.data.grubhub.com/manager?project=gdp_ingestion_events_carereporting&flow=carereporting-ticket_data-ingestion#executions


echo "=-=-=-=- V2 Links - Feeds -=-=-=-="
grep -v raw ${input_file} | grep V2 | sort | awk -F $'\t' '{print $1}' | sort | uniq | \
	awk '{print "http://azkaban-dr.gdp.data.grubhub.com/manager?project=gdp_ingestion_events_"$1"&flow="$1"-raw_ingestion#executions"}'

echo "\n=-=-=-=- Factory Links - Feeds -=-=-=-="
grep -v raw ${input_file} | grep Factory | sort | awk -F $'\t' '{print $1}' | sort | uniq | \
	awk '{print "http://azkaban-dr.gdp.data.grubhub.com/manager?project=gdp_streaming_ingestion_events_"$1"&flow=ingest_"$1"_raw#executions"}'

#-=-=-=- Events -=-=-=-
echo "=-=-=-=- V2 Links - Events -=-=-=-="
grep -v raw ${input_file} | grep V2 | sort | uniq | \
	awk -F $'\t' '{print "http://azkaban-dr.gdp.data.grubhub.com/manager?project=gdp_ingestion_events_"$1"&flow="$1"-"$2"-ingestion#executions"}'

echo "\n=-=-=-=- Factory Links - Events -=-=-=-="
grep -v raw ${input_file} | grep Factory | sort | uniq | \
	awk -F $'\t' '{print "http://azkaban-dr.gdp.data.grubhub.com/manager?project=gdp_streaming_ingestion_events_"$1"&flow=ingest_"$2"_payload#executions"}'

