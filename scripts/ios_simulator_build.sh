#!/bin/bash

set -ex

#sh scripts/ios_install_certificates.sh

sh scripts/review_build.sh

rm -r ~/Library/Developer/Xcode/DerivedData
(cd ../test_app;flutter build ios --simulator)
