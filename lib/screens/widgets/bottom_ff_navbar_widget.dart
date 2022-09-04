import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/providers/auth.dart';
import 'package:flutter_project/screens/artist_bookings_screen.dart';
import 'package:flutter_project/screens/chats_screen.dart';
import 'package:flutter_project/screens/my_booking_screen.dart';
import 'package:flutter_project/screens/notifications_screen.dart';
import 'package:flutter_project/screens/widgets/custom_drawer.dart';

class BottomFFNavbarWidget extends StatefulWidget {
  final int index;
  const BottomFFNavbarWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _BottomFFNavbarWidgetState createState() => _BottomFFNavbarWidgetState();
}

class _BottomFFNavbarWidgetState extends State<BottomFFNavbarWidget> {
  @override
  Widget build(BuildContext context) {
    final isCustomer = Provider.of<Auth>(context).currentUser!.isCustomer;
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.collections_bookmark),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.chat_bubble_2_fill),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_active),
          label: 'Notifications',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.of(context).pushReplacementNamed('/');
            break;
          case 1:
            isCustomer
                ? Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => CustomDrawer(
                        child: MyBookingScreen(),
                      ),
                    ),
                  )
                : Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => CustomDrawer(
                        child: ArtistBookingsScreen(),
                      ),
                    ),
                  );
            break;
          case 2:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => CustomDrawer(
                  child: ChatsScreen(),
                ),
              ),
            );
            break;
          case 3:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => CustomDrawer(
                  child: NotificationsScreen(),
                ),
              ),
            );
            break;
        }
      },
      // theme: FFNavigationBarTheme(
      //   selectedItemTextStyle: Theme.of(context)
      //       .textTheme
      //       .headline6!
      //       .copyWith(fontWeight: FontWeight.bold),
      //   unselectedItemTextStyle: Theme.of(context).textTheme.headline6!,
      //   barBackgroundColor: Colors.white,
      //   selectedItemBorderColor: Theme.of(context).colorScheme.secondary,
      //   selectedItemBackgroundColor: Theme.of(context).primaryColor,
      //   selectedItemIconColor: Colors.white,
      //   selectedItemLabelColor: Colors.black,
      //   showSelectedItemShadow: true,
      //   barHeight: 60,
      // ),
      currentIndex: widget.index,
    );
  }
}
