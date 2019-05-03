FROM alpine/git AS base

COPY . /test/.ssh/

RUN ls -altr /test/.ssh/