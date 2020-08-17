#!/usr/bin/env bash

function dexb() {
    docker exec -it $1 /bin/bash
}

function dexz() {
    docker exec -it $1 /bin/zsh
}

function dpr() {
    docker image prune
    docker container prune
}

alias dimg=docker images
alias dimp=docker image prune
alias drmi=docker rmi -f $(docker images -f dangling=true)
alias dpsa=docker ps -a
alias dpsl=docker ps -a -l

