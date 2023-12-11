#!/bin/bash

set -ex

#sh scripts/android_install_certificates.sh

sh scripts/review_build.sh

(cd test_app;flutter build apk)
