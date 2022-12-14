import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/Global.dart';
import 'package:flutter_project/providers/auth.dart';
import 'package:flutter_project/screens/artist_profile_screen.dart';
import 'package:flutter_project/screens/customer_profile_screen.dart';
import 'package:flutter_project/screens/widgets/custom_drawer.dart';
import './app_drawer_list_widget.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).currentUser;
    return Material(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: user!.isCustomer ? 40 : 0),
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    CustomDrawer.of(context)!.close();
                    // Navigator.of(context).pop();
                    //user.isCustomer
                    Global.user.isCustomer ?? false
                        ? Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => CustomDrawer(
                                child: CustomerProfileScreen(),
                              ),
                            ),
                          )
                        : Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => CustomDrawer(
                                child: ArtistProfileScreen(),
                              ),
                            ),
                          );
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 16.0, right: 8.0, bottom: 16.0, left: 8.0),
                        child: user.image != null && user.image != ''
                            ? CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(user.image),
                              )
                            : Icon(
                                Icons.face,
                                size: 48.0,
                                color: Colors.black,
                              ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                          Text(
                            user.email,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width / 2.5),
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                AppDrawerListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
