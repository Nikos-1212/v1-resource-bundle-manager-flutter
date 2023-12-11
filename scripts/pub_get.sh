#!/bin/bash

set -ex

(cd resource_bundle_manager; flutter pub get)
(cd test_app; flutter pub get)
(cd test_app; flutter precache --ios)
(cd test_app/ios; bundle install; pod install)
