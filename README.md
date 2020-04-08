# openemr-kube

## Deployment

```
kubectl apply -f databasevolume-persistentvolumeclaim.yaml,logvolume01-persistentvolumeclaim.yaml,mysql-deployment.yaml,mysql-service.yaml,openemr-deployment.yaml,openemr-service.yaml,sitevolume-persistentvolumeclaim.yaml
```
