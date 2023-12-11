abstract class ResourceBundleRouter {
  /// Retrieves a string value for the given key and locale. Returns null if not found.
  /// Returns Future Optional String
  Future<void> getResourceFor(String tenant, String withLocale, Function callback);
}