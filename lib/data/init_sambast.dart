import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

///initialization function of sembast
class InitSembast {
  static Future initialize() async {
  var database =   await _initSembast();
  }
 static DatabaseClient? databaseInstance;
  static  _initSembast() async {
    ///getting path
    final appDir = await getApplicationDocumentsDirectory();
    await appDir.create(recursive: true);
    ///adding semabst.db to path name to distinguish
    final databasePath = join(appDir.path, "sembast.db");
    ///opening database
    final database = await databaseFactoryIo.openDatabase(databasePath);

databaseInstance = database;

  }
}