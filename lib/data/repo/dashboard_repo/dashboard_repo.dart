import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:ropstom_task/data/init_sambast.dart';
import 'package:sembast/sembast.dart';

import '../../models/dashboard_model/dashboard_model.dart';

class DashboardRepo{
 static final StoreRef _store = intMapStoreFactory.store("Details");


 /// Add new Entry to DB
 static Future <bool> addNewEntry({required DashboardModel model}) async {
  try {
     await _store.add(InitSembast.databaseInstance!, dashboardModelToJson(model));

     return true;
   } on Exception catch (e) {
    Fluttertoast.showToast(msg: 'Something Went wrong while Adding data');
    return false;
     // TODO
   }
  }



  /// Fetch record from the DB
  static Future<List<DashboardModel>?> fetchRecord()async{
   try {
     final snapshots = await _store.find(InitSembast.databaseInstance!);
     List<DashboardModel> dataList = [];
     for(var data in snapshots){
       DashboardModel model =dashboardModelFromJson(int.parse(data.key.toString()),data.value.toString());
    dataList.add(model);
     }
     return dataList;
   } on Exception catch (e) {
     return null;
   }
  }


  /// Delete record from DB
 static Future <bool>deleteRecord({required int id})async{
  try {
    await  _store.record(id).delete(InitSembast.databaseInstance!);
    return true;
  } on Exception catch (e) {
   return false;
    // TODO
  }
  }



 /// Update record in DB
  static Future<List<DashboardModel>?> updateRecord({required DashboardModel model}) async {
   try {
  await  _store.record(model.id).update(InitSembast.databaseInstance!, dashboardModelToJson(model));
  final snapshots = await _store.find(InitSembast.databaseInstance!);
  List<DashboardModel> dataList = [];

  for(var data in snapshots){
    DashboardModel model =dashboardModelFromJson(int.parse(data.key.toString()),data.value.toString());
    dataList.add(model);
  }

  return dataList;
   } on Exception catch (e) {

     return null;
   }
  }
}