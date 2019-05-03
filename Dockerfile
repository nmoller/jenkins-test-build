FROM alpine/git AS base

ARG SSH_KEY

COPY ${SSH_KEY} /test/.ssh/test.txt

RUN cat /test/.ssh/test.txt