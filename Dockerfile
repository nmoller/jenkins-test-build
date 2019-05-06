FROM nmolleruq/builder:0.0.1 AS base

USER root

COPY . /root/

RUN git clone git@bitbucket.org:uqam/appbuilder.git test01

RUN php test01/bin/builder.php gitStuff -r -l -k test01/config/MM-535.json

RUN ls -altr build/moodle