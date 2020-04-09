This is rewrite of original [upstream image](https://github.com/openemr/openemr-devops/tree/master/docker/openemr/5.0.3).

Notable differences:
 - Based on UBI
 - Using multi-staged build (and hence results in smaller image size)
 - Without redis (needs to be spun-up separately)
 - without cron
 - without bundled ssl certificate
