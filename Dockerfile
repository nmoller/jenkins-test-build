FROM alpine/git AS base

ARG SSH_KEY

RUN cat ${SSH_KEY}