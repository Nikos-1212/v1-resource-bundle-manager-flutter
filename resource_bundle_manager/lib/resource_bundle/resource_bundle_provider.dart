/// Third-party imports
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:resource_bundle_manager/resource_bundle/resource_bundle_router.dart';
import 'package:resource_bundle_manager/resource_bundle_router.dart';

/// Local imports
import '../resource_provider.dart';
import '../app_localization_key.dart';

class ResourceBundleProvider extends ResourceProvider {
  var _locale = 'en';
  late Map _map;
  late final ResourceBundleRouter _router = ResourceBundleRouterImpl();

  Future<String> getFilePath() async {
    return 'assets/$_locale.json';
  }

  @override
  Future<void> setLocale(String locale) async {
    // print('ResourceBundleProvider.setLocale $locale');
    _locale = locale;
  }

  @override
  Future<String?> getValueFor(
      {required AppLocalizationKey key, List<String>? params}) async {
    /// For interim, load the json content from asset.
    /// Will be replaced by calling the _router.getResourceFor(tenant, locale);
    /// to retrieve the JSON content.

    Directory? directory = await getApplicationSupportDirectory();

    String filePath = '${directory.path}/downloaded_$_locale.json';
    File defaultFile = File('${directory.path}/downloaded_en.json');

    File file = File(filePath);

    try {
      _map = await json.decode(await file.readAsString()) as Map;
    } catch (e) {
      // print("Get keys from default locale en");
      _map = await json.decode(await defaultFile.readAsString()) as Map;
    }

    if (params == null) {
      return _map[key.name];
    }

    String text = _map[key.name];

    for (int i = 1; i < params.length + 1; i++) {
      var stringParam = "%$i\$@";
      text = text.replaceFirst(stringParam, params[i - 1]);
    }

    return text;
  }

  Future<void> downloadResourceBundle(
      String tenant, String locale, Function callback) async {
    return _router.getResourceFor(tenant, locale, callback);
  }

  Future<void> invalidateCache() async {
    /// Remove resource bundle cache
  }
}
