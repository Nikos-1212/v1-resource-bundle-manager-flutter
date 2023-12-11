/// Local imports
import '../resource_api_router.dart';

class RemoteAPIRouterImpl extends RemoteAPIRouter {
  @override
  Future<String?> getValueFor(String key, String withLocale) {
    return Future.value("A value for $key with locale $withLocale");
  }
}