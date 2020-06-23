#!/usr/bin/env bash
  CONTAINER_NAME="azure-new"
  IMAGE_NAME="azure-new"

  #image exists
  if [[ "$(docker images --filter reference=$IMAGE_NAME | grep -v "REPOSITORY")" ]]; then
    #container exist
    if [[ "$(docker ps -aq -f name=${CONTAINER_NAME})" ]]; then
      #container started
      if [[ "$(docker ps -q -f name=${CONTAINER_NAME})" ]]; then
        echo "container $CONTAINER_NAME is running"
      else
        echo "starting container $CONTAINER_NAME"
        docker start ${CONTAINER_NAME}
        echo "waiting 10s for starting of existing docker containter"
        sleep 10s
      fi
    else
      echo "starting image $IMAGE_NAME"
      docker run -p 7071:7071 -it -v $(pwd):/home --name ${CONTAINER_NAME} ${IMAGE_NAME} /bin/bash
    fi
  else echo "Image  kafka-connect-base doesn't exist"
  fi



#docker run -p 7071:7071 -it -v $(pwd):/home --name "azure-new"