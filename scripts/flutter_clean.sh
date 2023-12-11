#!/bin/bash

set -ex

(cd resource_bundle_manager; flutter clean)
(cd test_app; flutter clean)
