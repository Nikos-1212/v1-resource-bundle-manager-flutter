/// Third-party imports

/// Package imports
import 'package:resource_bundle_manager/remote_api/remote_api_router.dart';
import 'package:resource_bundle_manager/resource_api_router.dart';

/// Local imports
import '../resource_provider.dart';
import '../app_localization_key.dart';

class RemoteResourceProvider extends ResourceProvider {
  var _locale = '';
  late final RemoteAPIRouter _router = RemoteAPIRouterImpl();

  @override
  Future<String?> getValueFor(
      {required AppLocalizationKey key, List<String>? params}) {
    return _router.getValueFor(key.name, _locale);
  }

  @override
  Future<void> setLocale(String locale) async {
    // print('RemoteResourceProvider.setLocale $locale');
    _locale = locale;
  }
}
