#!/usr/bin/env bash

source common.bash

if [ ! -d "$WORKING_DIR" ]; then
    mkdir -p $WORKING_DIR
fi

# Create the final gf script from template
sed \
    -e "s/\${LOCATOR_NAME}/$INSTANCE_NAME-locator/g" \
    -e "s/\${SERVER_NAME}/$INSTANCE_NAME-server/g" \
    -e "s/\${LOCATOR_PORT}/$LOCATOR_PORT/g" \
    -e "s/\${CACHE_SERVER_PORT}/$CACHE_SERVER_PORT/g" \
    -e "s/\${MAX_WAIT}/$MAX_WAIT/g" \
    -e "s/\${JMX_MANAGER_PORT}/$JMX_MANAGER_PORT/g" \
    -e "s/\${HTTP_SERVICE_PORT}/$HTTP_SERVICE_PORT/g" \
    -e "s/\${HEAP_SIZE}/$HEAP_SIZE/g" \
    -e "s|\${WORKING_DIR}|$WORKING_DIR|g" \
    templates/server-template.gf > start-server.gf

gfsh run --file=start-server.gf

echo "Connect to the cache server with: "
echo "gfsh"
echo "connect --locator=localhost[$LOCATOR_PORT]"