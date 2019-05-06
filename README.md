# Usage

Vérifier que le tag de l'image correspond à l'id du build que vous voulez utiliser.

Démarrer l'environment :
```
docker-compose up -d
```

S'assurer d'avoir l'uid de `www-data` (faire `cat /etc/passwd`)

```
# s'assurer que 
docker exec -it test01_webserver_1 mkdir /var/www/moodledata
docker exec -it test01_webserver_1 chown -R 600:600 /var/www/moodledata

docker exec -it test01_webserver_1 mkdir /tmp/moodle
docker exec -it test01_webserver_1 chown -R 600:600 /tmp/moodle

# Si vous n'est pas sur https:
docker exec -it test01_webserver_1 sed -i -e "s#\$CFG->sslproxy = true;##" /var/www/html/config.php

# nouvelle installation
docker exec -it -u 600:600 \ 
test01_webserver_1 \
php /var/www/htmladmin/cli/install_database.php --adminpass=s3cr3t --agree-license

```

## Nouvelle version

Voir:

https://github.com/heathrow-inc/docker-mysql

pour la base de l'image `heathrow/mysql:5.7`

Comme `www-data` par défaut et le dossier moodledata existe déjà:
```
docker exec -it test01_webserver_1 mkdir /tmp/moodle
docker exec -it test01_webserver_1 chown -R 33:33 /tmp/moodle

# Si vous n'est pas sur https:
docker exec -it test01_webserver_1 sed -i -e "s#\$CFG->sslproxy = true;##" /var/www/html/config.php

# nouvelle installation
docker exec -it -u 33:33 \ 
test01_webserver_1 \
php /var/www/htmladmin/cli/install_database.php --adminpass=s3cr3t --agree-license
```

## Extras

Si erreur `Block type messages has been disabled by the administrator.`
https://moodle.org/mod/forum/discuss.php?d=344169

La solution dans:

https://tracker.moodle.org/browse/MDL-24254

Block messages n'existe plus. Modifier `config.php` pour créer cours.