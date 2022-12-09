import 'package:logging/logging.dart';


final log = Logger('EW');

void setupLogger() {
  //TODO: implement later
  // const isProd = bool.fromEnvironment(isProductionEnvKey, defaultValue: false);
  const isProd = false;
  Logger.root.level = isProd ? Level.OFF : Level.ALL;
  Logger.root.onRecord.listen((record) {
    // It's used for printing in dev environment
    // ignore: avoid_print
    print('${record.level.name}, ${record.time}, '
        'Msg: ${record.message}, '
        '${record.error != null ? 'Error: ${record.error}, ' : ''}'
        '${record.stackTrace != null ? 'StackTrace: ${record.stackTrace}' : ''}');
  });
}
