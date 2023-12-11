import 'package:flutter_test/flutter_test.dart';
import 'package:framework_contracts_flutter/resource_manager/resource_common_contract.dart';
import 'package:resource_bundle_manager/app_localization_key.dart';

import 'package:resource_bundle_manager/resource_bundle_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('initConfig', () {
    test('returns void when called', () {
      expect(
        () async => await VGStringProvider.instance.initConfig(
            ResourceConfig(tenant: "9998", locale: "en", groupId: "")),
        isA<void>(),
      );
    });

    // test('creates a file in Application Support Directory', () async {
    //   await ResourceBundleManager.instance.initConfig("9998", "en", () async {
    //     Directory directory = await getApplicationSupportDirectory();
    //
    //     String filePath = '${directory.path}/downloaded_en.json';
    //     File file = File(filePath);
    //     expect(file.exists(), isTrue);
    //   });
    // });
  });

  group('valueOf', () {
    // test(
    //     'returns a correct string for acFirstTimeSpinSuccessScreenTitle_5181 key',
    //     () async {
    //   await ResourceBundleManager.instance.initConfig("9998", "en", () async {
    //     expect(
    //         await ResourceBundleManager.instance.valueOf(
    //             key: AppLocalizationKey.acFirstTimeSpinSuccessScreenTitle_5181),
    //         equals("Set up complete!"));
    //   });
    // });

    test('returns a correct string for welcome_screen_1 key', () async {
      VGStringProvider.instance
          .initConfig(ResourceConfig(tenant: "9998", locale: "en", groupId: ""),
              callback: () async {
        expect(
            await VGStringProvider.instance.valueOf(
              key: AppLocalizationKey.welcome_screen_1,
            ),
            equals("Healthy living has never been this rewarding"));
      });
    });
  });
}
