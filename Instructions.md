# Openemr-kube

# The purpose of this project is to make it possible to quickly deploy a fully functional electronic health records system (EHR) as a Kubernetes resource. While these instructions should work in any current Kubernetes environment. The target Kubernetes platform for these is OpenShift.com

### Perequisites
You must have git installed. Please sign up a free OpenShfit account at manage.openshift.com. You are also encouraged to fork this project on Github so that you may make custom edits.

### Steps
1. From the OpenShift portal, download the Command Line Tools from the Help (? button) menu. Download the oc command line client for your platform. e.g., Linux, macOS, Windows. The oc tool is available through Homebrew as well: brew install openshift-cli

2. In the OpenShift portal click your name, then click "Copy the Login Command", then paste that command into your command line. e.g., ``` oc login --token=VAw1hSirRaUmLKuGgGsZe0_mbKEtGdia5NXokYfTxc4 --server=https://api.us-east-1.starter.openshift-online.com:6443 ```

3. From the command line, type in a new for your project. ``` oc new-project openemr ```

4. Clone this repository to your local system. e.g., ``` git clone https://github.com/RedHatOfficial/openemr-kube.git ```, then cd into the directory.

5. Run: ``` oc apply -f artifacts/mysql/ ```

6. Then run ``` oc apply -f artifacts/phpmyadmin/ ```

7. Deploy OpenEMR by running: ``` oc apply -f artifacts/openemr/ ```

8. Finally, run: ``` oc apply -f artifacts/openemr-firstboot ```

9. List names of services. ``` oc get svc ```

10. Create a route. ``` oc expose svc/openemr --hostname=emr2.apps.cloudapps.northwestern.edu ```

11. Set cookie:  ``` oc get routes ``` then set the cookie e.g., ``` oc annotate route openemr router.openshift.io/cookie_name=my_cookie ``` Setting a the cookie is important if you have multipule instances or OpenEMR containers running https://docs.openshift.com/container-platform/3.11/dev_guide/routes.html

#### Other tips

# Auto scale the app
``` oc autoscale deploy openemr --min=2 --max=10 ```

``` oc autoscale deployment.apps/openemr --max=5 --cpu-percent=80 ``