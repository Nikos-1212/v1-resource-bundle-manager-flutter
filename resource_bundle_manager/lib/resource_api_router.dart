abstract class RemoteAPIRouter {
  /// Retrieves a string value for the given key and locale. Returns null if not found.
  /// Returns Future Optional String
  Future<String?> getValueFor(String key, String withLocale);
}