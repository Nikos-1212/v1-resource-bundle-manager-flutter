#!/usr/bin/env bash

#Clone the certificates
if [[ -n "${KEYSTORE_BRANCH}" ]]
then
    tgtBranch=${KEYSTORE_BRANCH}
else
    tgtBranch=${ANDROID_KEYSTORE_BRANCH}
fi

GIT_SERVER_URL=`dirname $GIT_REPOSITORY_URL`
git clone -b $tgtBranch $GIT_SERVER_URL/v1-mobile-certificates mobile-certs


echo -e "\n[INFO] Displaying the last two commits in the ${tgtBranch} branch \n"
cd mobile-certs && git log -n 2 && cd ..
tree mobile-certs

# Install CA-Certificate
sudo apt install ca-certificates

# Install the signing certificate
if [[ -z "${MATCH_PASSWORD}" ]]
then
echo MATCH_PASSWORD is not set!
exit 1
fi

mkdir -p ${ANDROID_KEYSTORE_PATH}
pushd  mobile-certs

brew install p7zip

7z x -o${ANDROID_KEYSTORE_PATH} test_app/android.keystore.zip -p${MATCH_PASSWORD}
            
ls -l ${ANDROID_KEYSTORE_PATH}/android_keystore
md5sum ${ANDROID_KEYSTORE_PATH}/android_keystore
keytool -list -keystore ${ANDROID_KEYSTORE_PATH}/android_keystore --storepass ${ANDROID_KEYSTORE_PASSWORD}