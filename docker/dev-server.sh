#!/bin/bash
# runs webpack in react container

NODE_ENV=${1:-dev-server}
echo "Running with NODE_ENV=$NODE_ENV"

# stop and remove the containers if they are running
stop_and_remove_container()
{
    docker stop react-json-view
    docker rm react-json-view
}
stop_and_remove_container || true

# run the workbench container
docker run \
    -v $(pwd)/src:/react/src \
    -v $(pwd)/dev-server:/react/dev-server \
    -v $(pwd)/entrypoints:/react/entrypoints \
    -v $(pwd)/webpack.config.js:/react/webpack.config.js \
    --name=react-json-view \
    -e NODE_ENV=$NODE_ENV \
    --publish 2000:2000 \
    --entrypoint=/react/entrypoints/dev-server.sh \
    -t react-json-view