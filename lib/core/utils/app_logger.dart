/// Lightweight logger utility matching JurisLaw's appLogger pattern.
///
/// Usage:
///   final _log = appLogger(MyClass);
///   _log.i('Info message');
///   _log.e('Error: $e');
///   _log.d('Debug value: $value');
class AppLogger {
  AppLogger(this._tag);

  final String _tag;

  void i(String message) {
    // ignore: avoid_print
    print('ℹ️  [$_tag] $message');
  }

  void d(String message) {
    assert(() {
      // ignore: avoid_print
      print('🐛  [$_tag] $message');
      return true;
    }());
  }

  void w(String message) {
    // ignore: avoid_print
    print('⚠️  [$_tag] $message');
  }

  void e(String message) {
    // ignore: avoid_print
    print('🔴  [$_tag] $message');
  }
}

/// Factory function — mirrors JurisLaw's `appLogger(ClassName)` usage.
AppLogger appLogger(Type type) => AppLogger(type.toString());
