import 'package:flutter/material.dart';
import 'package:flutter_project/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/providers/auth.dart';

class Global {
  static bool incompleteProfile = false;
  static late User user;
  static bool completeLater = false;
  static late int currentUID;
  static var subCats;
  static bool phoneAuthDone = false;
  static String userPhoneNumber = "";

  static void recordTheNumber(BuildContext context, String newNumber) {
    Map<String, String> _newData = {
      'mobile': newNumber,
    };
    Provider.of<Auth>(context, listen: false).editNumberInfo(
      _newData['mobile']!,
    );
  }

  static void showSnackbarMessage(
      String msg, IconData icon, Color iconColor, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: Duration(milliseconds: 400),
          content: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  msg,
                ),
              ),
            ],
          )),
    );
  }
}
