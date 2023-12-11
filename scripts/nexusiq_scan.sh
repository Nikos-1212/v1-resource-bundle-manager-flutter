#!/usr/bin/env bash

set -ex

 # Create App entry on Nexus IQ if doesn't exist.
              curl -u "$NEXUS_IQ_USERCODE:$NEXUS_IQ_PASSCODE" -X POST -H "Content-Type:application/json" "https://iqnexus.federation.vitalitydeveloper.com/api/v2/applications" -d \
              '{"publicId":"'"$BITRISE_APP_TITLE"'", "name":"'"$BITRISE_APP_TITLE"'", "organizationId":"e15e4b7e41e34be79e51d57dd6076b93", "contactUserName":"P01FAISALS","applicationTags":[]}'
              
              # Download the Nexus IQ CLI Jar and store it on the tmp directory
              wget https://download.sonatype.com/clm/scanner/latest.jar -O /tmp/nexus-iq-cli.jar
              chmod +x /tmp/nexus-iq-cli.jar

              # Scan repository
              java -Dsun.misc.URLClassPath.disableJarChecking=true \
                  --add-opens jdk.naming.rmi/com.sun.jndi.rmi.registry=ALL-UNNAMED \
                  --add-opens java.base/java.lang=ALL-UNNAMED \
                  --add-opens java.base/sun.security.action=ALL-UNNAMED \
                  --add-opens java.base/sun.net=ALL-UNNAMED \
                  --add-opens java.base/java.util=ALL-UNNAMED \
                  -jar /tmp/nexus-iq-cli.jar \
                  --application-id ${BITRISE_APP_TITLE} \
                  --server-url ${NEXUS_IQ_SERVER_URL} \
                  --resource_bundle_manager $NEXUS_IQ_USERCODE:$NEXUS_IQ_PASSCODE .
