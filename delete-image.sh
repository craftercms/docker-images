#!/bin/bash
TAG=$1

docker image rm -f craftercms/authoring_tomcat:$TAG craftercms/authoring_local:$TAG craftercms/delivery_tomcat:$TAG craftercms/deployer:$TAG craftercms/git_ssh_server:$TAG craftercms/git_https_server:$TAG craftercms/logrotate:$TAG
