FROM nmolleruq/builder:0.0.1 AS base

# Attention la variable qui determine où sera le build est dans le 
# config/....json
ENV build_root=build/moodle/
# lu à partir des paramètres fournis par Jenkins
ARG branch

USER root

WORKDIR /opt/

COPY . /root/

# On pourrait travailler avec des branches différentes et la passer par commande comme paramètre.
RUN git clone --depth 1 -b $branch --single-branch git@bitbucket.org:uqam/appbuilder.git test01

# Moodle 3.0
# RUN php test01/bin/builder.php gitStuff -r -l -k test01/config/MM-535.json

#Moodle 3.5
RUN php test01/bin/builder.php gitStuff -r -l -k test01/config/build.json

# Nettoyage
RUN rm -rf ${build_root}.git && rm -f {build_root}behat.yml.dist {build_root}TRADEMARK.txt \
   {build_root}README.txt \
   {build_root}Gruntfile.js {build_root}COPYING.txt {build_root}.travis.yml \
   {build_root}.shifter.json .{build_root}jshintrc {build_root}.gitignore \
   {build_root}.gitattributes {build_root}.eslintrc {build_root}.eslintignore \
   {build_root}.csslintrc {build_root}config-dist.php \
   {build_root}phpunit.xml.dist {build_root}package.json {build_root}npm-shrinkwrap.json 

# Pour voir la taille sur l'image.
#RUN du -sh /opt/${build_root} && ls -altr /opt/${build_root}

RUN git clone --depth 1 -b UQAM_30_k8s --single-branch git@bitbucket.org:uqam/configphp.git moodleconfig


# Prendre comme base https://github.com/moodlehq/moodle-php-apache
# Version 3.0 ne fonctionne pas...
#FROM moodlehq/moodle-php-apache:7.1
#FROM moodlehq/moodle-php-apache:7.0
FROM moodlehq/moodle-php-apache:7.3
#FROM nmolleruq/mdlhb-cecl:p1.4-dev
COPY --from=base /opt/build/moodle /var/www/html
COPY --from=base /opt/moodleconfig/config.php /var/www/html/config.php

RUN sed -i -e "s/post_max_size = 8M/post_max_size = 250M/g" /usr/local/etc/php/php.ini-production && \
    sed -i -e "s/upload_max_filesize = 2M/upload_max_filesize = 250M/g" /usr/local/etc/php/php.ini-production && \
    sed -i -e "s/memory_limit = 128M/memory_limit = 1024M/g" /usr/local/etc/php/php.ini-production && \
    cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini && \
    #Set de locales
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "fr_CA.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen