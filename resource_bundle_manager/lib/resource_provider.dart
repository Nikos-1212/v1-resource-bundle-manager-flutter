import '../app_localization_key.dart';

abstract class ResourceProvider {
  /// Sets the source locale of the resource
  /// Returns a Future void.
  Future<void> setLocale(String locale);

  /// Retrieves the value for the given AppLocalizationKey. Null if not found.
  /// Returns Future Optional String
  Future<String?> getValueFor(
      {required AppLocalizationKey key, List<String>? params});
}
