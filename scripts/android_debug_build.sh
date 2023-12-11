#!/bin/bash

set -ex

sh scripts/review_build.sh

(cd test_app;flutter build apk --debug)
