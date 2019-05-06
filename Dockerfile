FROM nmolleruq/builder:0.0.1 AS base

# Attention la variable qui determine où sera le build est dans le 
# config/....json
ENV build_root=build/moodle/

USER root

WORKDIR /opt/

COPY . /root/

# On pourrait travailler avec des branches différentes et la passer par ENV comme paramètre.
RUN git clone --depth 1 git@bitbucket.org:uqam/appbuilder.git test01

RUN php test01/bin/builder.php gitStuff -r -l -k test01/config/MM-535.json

# Nettoyage
RUN rm -rf ${build_root}.git && rm -f {build_root}behat.yml.dist {build_root}TRADEMARK.txt \
   {build_root}README.txt \
   {build_root}Gruntfile.js {build_root}COPYING.txt {build_root}.travis.yml \
   {build_root}.shifter.json .{build_root}jshintrc {build_root}.gitignore \
   {build_root}.gitattributes {build_root}.eslintrc {build_root}.eslintignore \
   {build_root}.csslintrc {build_root}config-dist.php \
   {build_root}phpunit.xml.dist {build_root}package.json {build_root}npm-shrinkwrap.json 

RUN du -sh /opt/${build_root} && ls -altr /opt/${build_root}

RUN git clone --depth 1 -b UQAM_30_k8s --single-branch git@bitbucket.org:uqam/configphp.git moodleconfig


# Prendre comme base https://github.com/moodlehq/moodle-php-apache
#FROM nmolleruq/..... 
FROM moodlehq/moodle-php-apache:7.2
COPY --from=base /opt/build/moodle /var/www/html
COPY --from=base /opt/moodleconfig/config.php /var/www/html/config.php