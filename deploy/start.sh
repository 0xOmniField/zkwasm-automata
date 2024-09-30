./usr/src/zkwasm-typescript-mini-server/target/release/csm_service --uri $URI & node /usr/src/zkwasm-automata/ts/node_modules/zkwasm-ts-server/src/service.js redis

# Wait for any process to exit
wait -n

# Exit with status of the process that exited first
exit $?
~

