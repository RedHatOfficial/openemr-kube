# openemr-kube

## Deployment in OpenShift (v3 or v4)

```
oc create -f sitevolume-persistentvolumeclaim.yaml,databasevolume-persistentvolumeclaim.yaml,logvolume01-persistentvolumeclaim.yaml,websitevolume-persistentvolumeclaim.yaml,sslvolume-persistentvolumeclaim.yaml,mysql-deployment.yaml,mysql-service.yamlopenemr-deployment.yaml,openemr-service.yaml
```

## Deployment in vanilla kubernetes

```
kubectl apply -f databasevolume-persistentvolumeclaim.yaml,logvolume01-persistentvolumeclaim.yaml,mysql-deployment.yaml,mysql-service.yaml,openemr-deployment.yaml,openemr-service.yaml,sitevolume-persistentvolumeclaim.yaml
```

### Quay organization

https://quay.io/organization/openemr
