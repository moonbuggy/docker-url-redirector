# syntax = docker/dockerfile:1.4.0

ARG FROM_IMAGE="moonbuggy2000/alpine-s6-nginx"

FROM "${FROM_IMAGE}"
COPY root/ /
