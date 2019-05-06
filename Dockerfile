FROM nmolleruq/builder:0.0.1 AS base

ENV build_root=build/moodle/

USER root

COPY . /root/

RUN git clone git@bitbucket.org:uqam/appbuilder.git test01

RUN php test01/bin/builder.php gitStuff -r -l -k test01/config/MM-535.json

# Nettoyage
RUN rm -rf ${build_root}.git && rm -f {build_root}behat.yml.dist {build_root}TRADEMARK.txt \
   {build_root}README.txt \
   {build_root}Gruntfile.js {build_root}COPYING.txt {build_root}.travis.yml \
   {build_root}.shifter.json .{build_root}jshintrc {build_root}.gitignore \
   {build_root}.gitattributes {build_root}.eslintrc {build_root}.eslintignore \
   {build_root}.csslintrc {build_root}config-dist.php \
   {build_root}phpunit.xml.dist {build_root}package.json {build_root}npm-shrinkwrap.json 

RUN du -sh ${build_root}