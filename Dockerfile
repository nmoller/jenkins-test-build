FROM alpine/git AS base

COPY . /test

RUN ls -altr /test/.ssh/