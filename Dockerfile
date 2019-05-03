FROM alpine/git AS base

ARG SSH_KEY

RUN echo ${SSH_KEY}