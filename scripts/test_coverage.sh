#!/bin/bash

set -e

function generateCoverage {
  echo "Generating test coverage for resource_bundle_manager"
  (cd resource_bundle_manager; flutter test --coverage)
  (cd resource_bundle_manager/coverage; sed -i '' "s|SF:lib/|SF:resource_bundle_manager/lib/|g" lcov.info)

  echo "Combining all coverage into file://$(pwd)/all_coverage/combined-coverage.info"
  lcov --add-tracefile resource_bundle_manager/coverage/lcov.info --base-directory resource_bundle_manager/lib --no-external -d resource_bundle_manager \
       --output-file all_coverage/combined-coverage.info
  echo "Generating html file test coverage for resource_bundle_manager"
  genhtml all_coverage/combined-coverage.info --output-directory all_coverage/html --show-details
  echo "Open this file file://$(pwd)/all_coverage/html/index.html"
}

if [[ "$OSTYPE" == "darwin"* ]]; then
  if command -v lcov >/dev/null 2>&1; then
    generateCoverage
  else
    echo "lcov is not installed in mac"
    echo "Installing lcov using this command 'brew install lcov'"
    brew install lcov
  fi
elif [[ "$OSTYPE" == "msys" ]]; then
  if where lcov >/dev/null 2>&1; then
    generateCoverage
  else
    echo "lcov is not installed in windows"
    echo "Please refer to the following link for more information: https://github.com/linux-test-project/lcov."
  fi
else
  echo "Unknown operating system"
fi
