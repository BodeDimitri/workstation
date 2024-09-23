#!/bin/bash

root_dir=""
root_dir_back=""
container_name_back=""
root_dir_front=""
container_name_front=""
frontend_dir=""
frontend_repo=""
backend_dir=""
backend_repo=""


check_update() {
    local dir=$1
    local repo_url=$2
    local output
    local status

    cd "$dir" || exit
    output=$(git pull "$repo_url" 2>&1)
    if echo "$output" | grep -q "Already up to date."; then
        status=1 
        if  docker ps -a | awk '$2 ~ /$container_name_back/ {print $7}' | grep -q "Exited" || docker ps -a | awk '$2 ~ /container_name_front/ {print $7}' | grep -q "Exited" ; then 
            echo "Repo atualizado e container não esta de pé"
            status=1
            cd "$root_dir"
            docker compose build
            docker-compose up -d
        else
            echo "Repo atualizado e container já está de pé."
        fi
    else
        status=0
        echo "Novo pull recebido, o repositório foi atualizado."
    fi
    return $status
}

echo "Checando o repositório backend"
check_update "$backend_dir" "$backend_repo"
resultBack=$?

echo "Checando o repositório frontend"
check_update "$frontend_dir" "$frontend_repo"
resultFront=$?

if [ "$resultBack" -eq 0 ] || [ "$resultFront" -eq 0 ]; then
    echo "#########################################################################"
    echo "Novo pull encontrado, fazendo o deploy automático e subindo novo container"
    echo "#########################################################################"

    docker ps -a | awk '$2 ~/$container_name_front/ {print $1}' | xargs docker stop | xargs docker rm
    docker ps -a | awk '$2 ~/$container_name_back/ {print $1}' | xargs docker stop | xargs docker rm

    echo "#########################################################################"
    echo "Parando o container"
    echo "#########################################################################"

    cd "$root_dir"
    docker compose build
    docker-compose up -d

    echo "#########################################################################"
    echo "O container está subindo"
    echo "#########################################################################"

    if [ $? -eq 0 ]; then
        echo "#########################################################################"
        echo "Container subiu com sucesso"
        echo "#########################################################################"
    else
        echo "#########################################################################"
        echo "Algo deu errado, chama o Diego"
        echo "#########################################################################"
    fi
else
    echo "#########################################################################"
    echo "Os repositórios já estão atualizados."
    echo "#########################################################################"
fi