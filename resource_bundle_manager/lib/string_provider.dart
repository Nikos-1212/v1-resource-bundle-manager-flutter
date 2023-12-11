/// Local imports
import 'package:framework_contracts_flutter/framework_contracts_flutter.dart';

import 'localization_source.dart';
import '../app_localization_key.dart';

abstract class StringProvider extends ResourceCommonProvider {
  /// Sets the source locale of the resource
  /// Returns a Future void.

  /// Retrieves the value for the given AppLocalizationKey and LocalizationSource. Returns null if not found.
  /// Returns Future Optional String
  Future<String?> valueOf(
      {required AppLocalizationKey key,
      List<String>? params,
      LocalizationSource source = LocalizationSource.local});
}
