#!/bin/bash

set -ex

(cd resource_bundle_manager; flutter pub run build_runner build --delete-conflicting-outputs)
(cd test_app; flutter pub run build_runner build --delete-conflicting-outputs)
