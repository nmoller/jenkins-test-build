FROM nmolleruq/builder:0.0.1 AS base

COPY . /home/uqamena/

RUN ls -altr /home/uqamena/.ssh && whoami && chmod 600  /home/uqamena/.ssh/test

RUN git clone git@bitbucket.org:uqam/appbuilder.git test01

RUN php test01/bin/builder.php gitStuff -r -l -k test01/config/MM-535.json

RUN ls -altr test01/build