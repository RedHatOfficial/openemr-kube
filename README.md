# openemr-kube

[![openmr image build](https://quay.io/repository/openemr/openemr/status "openmr image build")](https://quay.io/repository/openemr/openemr)

## Deployment in OpenShift (v3 or v4)

```
oc apply -f artifacts/
```

## Deployment in vanilla kubernetes

```
kubectl apply -f artifacts/
```

### Testing Cluster
A public OpenShift 4.3 cluster was created to facilitate testing:

https://console-openshift-console.apps.openemr-dev-1.naps-oct.redhatgov.io

Contact @isimluk for access.
