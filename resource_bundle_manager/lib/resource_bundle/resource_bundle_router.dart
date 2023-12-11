import 'dart:io';

import 'package:flutter/services.dart';

import '../resource_bundle_router.dart';
import 'package:path_provider/path_provider.dart';

class ResourceBundleRouterImpl extends ResourceBundleRouter {
  @override
  Future<void> getResourceFor(
      String tenant, String withLocale, Function callback) async {
    /// Retrieve resource for the given tenant and locale
    ///
    /// For Simulation:
    /// Copy the base.json and saved it in the application directory
    ///
    ///

    String rawValue;

    try {
      rawValue = await rootBundle.loadString(
          'packages/resource_bundle_manager/assets/sample_api_resource_$withLocale.json');
    } catch (e) {
      // print("===> Source not found, switching to default en");
      withLocale = "en";
      rawValue = await rootBundle.loadString(
          'packages/resource_bundle_manager/assets/sample_api_resource_en.json');
    }

    // Map<String, dynamic> arbMap = json.decode(rawValue);

    Directory? directory = await getApplicationSupportDirectory();

    String filePath = '${directory.path}/downloaded_$withLocale.json';

    // print("===> $directory");

    File file = File(filePath);

    if (await file.exists() == false) {
      await file.writeAsString(rawValue);
      // print("===> Saved to ApplicationSupportDirectory");
    } else {
      // print("===> No need to write to ApplicationSupportDirectory");
    }

    callback();
  }
}
