import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ropstom_task/data/init_sambast.dart';
import 'package:sembast/sembast.dart';

class AuthenticationRepo {
  static final StoreRef _store = intMapStoreFactory.store("Users");

  ///registering new user
  static Future<bool> registerUser({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      ///checking if email already exists or not
      var finder = await _store.find(
        InitSembast.databaseInstance!,
        finder: Finder(
          filter: containsMapFilter(
            {
              "email": email,
            },
          ),
        ),
      );

      if (finder.isNotEmpty) {
        ///email already exists show this toast
        Fluttertoast.showToast(
            msg: 'Email Already taken', backgroundColor: Colors.red);
        return false;
      } else {
        ///if emails not exists then add new user
        var id = await _store.add(InitSembast.databaseInstance!, {
          'user_name': userName,
          "email": email,
          "password": password,
          "user_id": '',
        });

        _store.record(id).update(InitSembast.databaseInstance!, {
          "user_id": id,
        });
        return true;
      }
    } on Exception catch (e) {
      ///on exception
      Fluttertoast.showToast(msg: 'Sign up Error: ${e.toString()}');
      return false;
      // TODO
    }
  }

  ///filtering and mapping
  static Filter containsMapFilter(Map<String, Object?> map) {
    return Filter.and(
        map.entries.map((e) => Filter.equals(e.key, e.value)).toList());
  }

  ///LogIn function
  static Future<bool> logInUser({
    required String email,
    required String password,
  }) async {
    try {
      ///checking if we have user in db
      var finding = await _store.find(InitSembast.databaseInstance!,
          finder: Finder(
              filter: containsMapFilter({
            "email": email,
            "password": password,
          })));

      if (finding.isEmpty) {
        ///if user not found
        Fluttertoast.showToast(
            msg: 'User name or password incorrect',
            backgroundColor: Colors.red);
        return false;
      } else {
        ///if user found return this
        return true;
      }
    } on Exception catch (e) {
      ///on exception
      Fluttertoast.showToast(msg: 'login up Error: ${e.toString()}');
      return false;
      // TODO
    }
  }
}
