# openemr-kube

## Deployment in OpenShift

```
oc create -f sitevolume-persistentvolumeclaim.yaml,databasevolume-persistentvolumeclaim.yaml,logvolume01-persistentvolumeclaim.yaml,mysql-deployment.yaml,mysql-service.yamlopenemr-deployment.yaml,openemr-service.yaml
```

```
kubectl apply -f databasevolume-persistentvolumeclaim.yaml,logvolume01-persistentvolumeclaim.yaml,mysql-deployment.yaml,mysql-service.yaml,openemr-deployment.yaml,openemr-service.yaml,sitevolume-persistentvolumeclaim.yaml
```

### Quay organization

https://quay.io/organization/openemr
