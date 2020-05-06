# openemr-kube

[![openmr image build](https://quay.io/repository/openemr/openemr/status "openmr image build")](https://quay.io/repository/openemr/openemr)

## Deployment

### Perequisites

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
