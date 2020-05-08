# openemr-kube

[![openmr image build](https://quay.io/repository/openemr/openemr/status "openmr image build")](https://quay.io/repository/openemr/openemr)

## Deployment

### Preequisites

In order to use OpenEMR, a MySQL database is required.
For development purposes, you can install a MariaDB database in the cluster:
```
oc apply -f artifacts/mysql/
```
or
```
kubectl apply -f artifacts/mysql/
```

For production purposes, a database should be created beforehand.
A Secret should be created in the namespace with the following structure:
```
apiVersion: v1
kind: Secret
metadata:
  name: mysql
type: Opaque
data:
  host: <A base64 encoded hostname (database endpoint)>
  name: <A base64 encoded database name>
  username: <A base64 encoded database username>
  password: <A base64 encoded database password>
  root_password: <A base64 encoded database root password>
```

### Deployment in OpenShift (v3 or v4)

```
oc apply -f artifacts/phpmyadmin/
oc apply -f artifacts/openemr/
```

For the first boot of the application certain initialization procedures (populating database and disk volumes) are required.
```
oc apply -f artifacts/openemr-firstboot
```

### Deployment in vanilla kubernetes

```
kubectl apply -f artifacts/phpmyadmin/
kubectl apply -f artifacts/openemr/
```

### Image Build Arguments

| Build Argument | Description | Default |
| -------------- | ----------- | ------- |
| OPENEMR_REPO_URL | The OpenEMR Git URL used to fetch source code | The OpenEMR's offical GitHubURL |
| OPENEMR_BRANCH | The OpenEMR branch built in the container | master |
| ENABLE_SSL | Indicates if the web server configuration includes SSL. Valid values are true or false | true | 

### Docker Compose Support for Local Use
```
docker-compose up -d

# review logs for database and openemr availability
docker-compose logs -f 

# run openemr setup process (a PHP Warning will appear)
docker-compose exec openemr sh -c "cd /var/www/localhost/htdocs/openemr && ./first_start.sh"

Running quick setup!
+ auto_setup
.....
PHP Warning:  mysqli_connect(): (HY000/1045): Access denied for user 'openemr'@'192.168.208.3' (using password: YES) in /var/www/localhost/htdocs/openemr/library/classes/Installer.class.php on line 69
.....
+ echo 'OpenEMR configured.'
OpenEMR configured.
++ php -r 'require_once('\''/var/www/localhost/htdocs/openemr/sites/default/sqlconf.php'\''); echo $config;'
+ CONFIG=1
+ '[' 1 == 0 ']'
+ '[' '' == yes ']'
+ echo 'Setup Complete!'
Setup Complete!
```

The Docker Compose configuration provides an easy way to work alternate OpenEMR forks and releases. To rebuild the application locally, simply update the `image` and `build` configurations.

```
image: <your repository name>/openemr:<your tag>
build:
  context: images/openemr
  args:
    OPENEMR_REPO_URL: <Valid Git URL>
    OPENEMR_BRANCH: <Git branch or tag name>
    ENABLE_SSL: <true | false>
```

Finally, if SSL support is enabled, add volume mounts to support the server cert and key

```
volumes:
- logvolume01:/var/log
- sitevolume:/var/www/localhost/htdocs/openemr/sites
- <local path>/<local cert>:/etc/ssl/certs/tls.crt
- <local path>/<local key>:/etc/ssl/certs/tls.key
```
