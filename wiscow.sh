#!/bin/bash

SRVPORT=${SRVPORT:-4499}
RSPFILE="/tmp/response"

handleRequest() {
    read request
    echo "Request: $request"

    # Generate response
    cat <<EOF > $RSPFILE
HTTP/1.1 200 OK
Content-Type: text/plain
Content-Length: $(fortune | cowsay | wc -c)

$(fortune | cowsay)
EOF
}

echo "Listening on $SRVPORT..."
prerequisites() {
    command -v cowsay >/dev/null 2>&1 &&
    command -v fortune >/dev/null 2>&1 || 
        { 
            echo "Install prerequisites."
            exit 1
        }
}

main() {
    prerequisites
    echo "Wisdom served on port=$SRVPORT..."

    while [ 1 ]; do
        cat $RSPFILE | nc -lN $SRVPORT | handleRequest
        sleep 0.01
    done
}

main