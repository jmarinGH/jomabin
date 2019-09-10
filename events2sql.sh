#!/usr/bin/env bash

feeds="$( sort feeds.txt | uniq | \
	awk '{print "(select '"'"'source_events_raw."$1"'"'"' tab, event_dt, count(*) rows from source_events_raw."$1" where event_dt > current_date - interval '"'"'7'"'"' day group by event_dt)\n UNION"  }' \
	)"

# select 'source_events_ordertakingstate.status_updates' tab, event_dt, count(*) rows from source_events_ordertakingstate.status_updates where event_dt > current_date - interval '7' day group by event_dt

events="$( sort events.txt | uniq | \
	awk '{print "(select '"'"'source_events_"$1"."$2"'"'"' tab, event_dt, count(*) rows from source_events_"$1"."$2" where event_dt > current_date - interval '"'"'7'"'"' day group by event_dt)\n UNION"  }' \
	)"

echo "select tab, event_dt, rows from ($feeds $events) order by event_dt DESC, tab"

