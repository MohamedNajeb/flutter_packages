part of log;


/// logger: ^0.8.0
class Log {
  static Logger _logger = Logger(
    printer: PrettyPrinter(colors: true, printEmojis: true, printTime: false),
  );

  static void d(String log) {
    _logger.d(log);
  }

  static void e(String log) {
    _logger.e(log);
  }

  static void w(String log) {
    _logger.w(log);
  }

  static void i(String log) {
    _logger.i(log);
  }
}
