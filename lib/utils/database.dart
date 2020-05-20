import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../provider/gmail_model.dart';

class DBProvider {
  String mailTable = 'mail_table';
	String colId = 'id';
	String by = 'by';
	String sent = 'sent';
	String subject = 'subject';
  String description = 'description';
  String date = 'date';



  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "new1MailDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
     await db.execute('CREATE TABLE $mailTable ($colId TEXT , $by TEXT,	$sent TEXT, $subject TEXT,$description TEXT,$date TEXT)');
			
         
    });
  }

  Future<void>newMail(Gmail _newMail) async {
    print("xyz");
    final db = await database;
    await db.insert(mailTable, _newMail.toMap());
   
  }

  Future<Gmail>getMail(String id) async {
    final db = await database;
    var res = await db.query(mailTable, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Gmail.fromMap(res.first) : Null;
  }

    Future< List<Gmail>>getAllMails() async {
      print("yes");
    final db = await database;
    var res = await db.query(mailTable);
    int count = res.length;
   List<Gmail> mailList = List<Gmail>();
		// For loop to create a 'todo List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			mailList.add(Gmail.fromMap(res[i]));
		}

		return mailList;
  }

  Future<void>deleteMail(String id) async {
    final db = await database;
   var res = await db.rawDelete('DELETE FROM $mailTable WHERE $colId = $id');
	
  }
}
