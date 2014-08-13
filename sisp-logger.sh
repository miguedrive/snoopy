#!/bin/bash

# Regla iptables para capturar el tráfico TCP & UDP
iptables -I FORWARD -m state --state NEW -j ULOG

# Obtener los RST Connections, para saber en que momento se cerró la conexión.
iptables -I FORWARD --protocol tcp --tcp-flags ALL RST,ACK -j ULOG

# Capturar el string "GET /" de HTTP
iptables -I FORWARD -m string --hex-string "|47 45 54 20 2F|" --algo bm -j ULOG
