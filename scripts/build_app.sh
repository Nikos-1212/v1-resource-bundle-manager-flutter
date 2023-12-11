set -ex

sh scripts/flutter_clean.sh

sh scripts/pub_get.sh

sh scripts/build_runner.sh

sh scripts/analyze.sh

sh scripts/test_coverage.sh

#(cd test_app/android; sh -c "./gradlew :authentication_android:lint")
(cd test_app;flutter build apk)

#(cd authentication_ios/ios; bundle exec pod lib lint --private --allow-warnings --sources="https://cdn.cocoapods.org/")

rm -r ~/Library/Developer/Xcode/DerivedData
(cd test_app;flutter build ios --simulator)
