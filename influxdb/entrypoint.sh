#!/usr/bin/env sh


if [ ! -f "/var/lib/influxdb/.init" ]; then
    exec influxd -config /usr/local/etc/influxdb.conf $@ &
	
	exec influx -host=localhost -port=8086 -execute="CREATE USER ${INFLUX_USER} WITH PASSWORD '${INFLUX_PASSWORD}' WITH ALL PRIVILEGES"
	exec	influx -host=localhost -port=8086 -execute="CREATE DATABASE ${INFLUX_DB}" 


    until wget -q "http://localhost:8086/ping" 2> /dev/null; do
        sleep 1
    done

       
    
	
	
	
	exec influxd -config /usr/local/etc/influxdb.conf $@ 
	
    
	touch "/var/lib/influxdb/.init"

    kill -s TERM %1
fi

exec influxd -config /usr/local/etc/influxdb.conf $@
