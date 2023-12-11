library localization_provider;

/// Third-party imports
import 'dart:async';

import 'package:framework_contracts_flutter/resource_manager/resource_common_contract.dart';

/// Package imports
import 'package:resource_bundle_manager/remote_api/remote_resource_provider.dart';
import 'package:resource_bundle_manager/resource_bundle/resource_bundle_provider.dart';

/// Local Imports
import 'string_provider.dart';
import 'localization_source.dart';
import '../app_localization_key.dart';

class VGStringProvider extends StringProvider {
  static final VGStringProvider _instance = VGStringProvider._();
  VGStringProvider._();
  static VGStringProvider get instance => _instance;

  String? _tenant;
  final ResourceBundleProvider _resourceBundleProvider =
      ResourceBundleProvider();
  final RemoteResourceProvider _remoteResourceProvider =
      RemoteResourceProvider();

  @override
  Future<void> initConfig(ResourceConfig config, {Function? callback}) async {
    _tenant = config.getTenant();

    await _resourceBundleProvider.setLocale(config.getLocale());
    await _remoteResourceProvider.setLocale(config.getLocale());

    assert(_tenant != null);
    if (null != _tenant) {
      _resourceBundleProvider.downloadResourceBundle(
          _tenant!, config.getLocale(), callback!);
    }
  }

  @override
  Future<String?> valueOf(
      {required AppLocalizationKey key,
      List<String>? params,
      LocalizationSource source = LocalizationSource.local}) async {
    switch (source) {
      case LocalizationSource.remote:
        return await _remoteResourceProvider.getValueFor(
            key: key, params: params);
      default:
        return await _resourceBundleProvider.getValueFor(
            key: key, params: params);
    }
  }

  @override
  Future<void> invalidateCache() async {
    await _resourceBundleProvider.invalidateCache();
  }
}
