FROM nmolleruq/builder:0.0.1 AS base

COPY . /home/uqamena/.ssh

RUN echo 'Host bitbucket.org' > /home/uqamena/.ssh/config && \
	echo 'StrictHostKeyChecking no' >> /home/uqamena/.ssh/config && \
	echo 'UserKnownHostsFile=/dev/null' >> /home/uqamena/.ssh/config

RUN git clone git@bitbucket.org:uqam/appbuilder.git test01

RUN php test01/bin/builder.php gitStuff -r -l -k test01/config/MM-535.json

RUN ls -altr test01/build