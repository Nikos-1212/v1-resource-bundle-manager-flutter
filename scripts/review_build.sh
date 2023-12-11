#!/bin/bash

set -ex

sh scripts/flutter_clean.sh

sh scripts/pub_get.sh

sh scripts/build_runner.sh

sh scripts/analyze.sh

sh scripts/test_coverage.sh
