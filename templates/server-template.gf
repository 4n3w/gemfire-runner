# GemFire Server Start Template
start locator --name=${LOCATOR_NAME} --port=${LOCATOR_PORT} --dir=${WORKING_DIR} \
    --bind-address=localhost --hostname-for-clients=localhost \
    --J=-Xmx${HEAP_SIZE} --J=-Xms${HEAP_SIZE} \
    --J=-Dgemfire.jmx-manager-port=${JMX_MANAGER_PORT} \
    --J=-Dgemfire.http-service-port=${HTTP_SERVICE_PORT} \
    --J=-Dgemfire.jmx-manager-hostname-for-clients=localhost \
    --log-level=config

sleep --time=${MAX_WAIT}

start server --name=${SERVER_NAME} --server-port=${CACHE_SERVER_PORT} \
    --dir=${WORKING_DIR} --locators=localhost[${LOCATOR_PORT}] \
    --bind-address=localhost --hostname-for-clients=localhost \
    --J=-Xmx${HEAP_SIZE} --J=-Xms${HEAP_SIZE} \
    --log-level=config

list members
status server --name=${SERVER_NAME}