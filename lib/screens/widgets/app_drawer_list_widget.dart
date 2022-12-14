import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/providers/auth.dart';
import 'package:flutter_project/screens/artist_bookings_screen.dart';
import 'package:flutter_project/screens/artist_change_password_screen.dart';
import 'package:flutter_project/screens/artist_current_bookings_screen.dart';
import 'package:flutter_project/screens/artist_profile_screen.dart';
import 'package:flutter_project/screens/chats_screen.dart';
import 'package:flutter_project/screens/customer_profile_screen.dart';
import 'package:flutter_project/screens/discount_code_screen.dart';
import 'package:flutter_project/screens/my_booking_screen.dart';
import 'package:flutter_project/screens/my_earnings_screen.dart';
import 'package:flutter_project/screens/my_wallet_screen.dart';
import 'package:flutter_project/screens/notifications_screen.dart';
import 'package:flutter_project/screens/receipt_screen.dart';
import 'package:flutter_project/screens/search_jobs_screen.dart';
import 'package:flutter_project/screens/tickets_screen.dart';
import 'package:flutter_project/screens/widgets/custom_drawer.dart';

class AppDrawerListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).currentUser;
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        DrawerItem(
          leading: Icon(
            Icons.home,
            color: Colors.white,
          ),
          title: Text(
            'Home',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
          ),
          onTap: () {
            // Navigator.of(context).pop();
            CustomDrawer.of(context)!.close();
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        DrawerItem(
          leading: Icon(
            Icons.collections_bookmark,
            color: Colors.white,
          ),
          title: Text(
            'My Bookings',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
          ),
          onTap: () {
            CustomDrawer.of(context)!.close();
            // Navigator.of(context).pop();
            user!.isCustomer
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
          },
        ),
        DrawerItem(
          leading: Icon(
            CupertinoIcons.chat_bubble_2_fill,
            color: Colors.white,
          ),
          title: Text(
            'Chats',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
          ),
          onTap: () {
            CustomDrawer.of(context)!.close();
            // Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => CustomDrawer(
                  child: ChatsScreen(),
                ),
              ),
            );
          },
        ),
        if (!user!.isCustomer)
          DrawerItem(
            leading: Icon(
              Icons.collections_bookmark,
              color: Colors.white,
            ),
            title: Text(
              'Current Bookings',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
            ),
            onTap: () {
              CustomDrawer.of(context)!.close();
              // Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => CustomDrawer(
                    child: ArtistCurrentBookingsScreen(),
                  ),
                ),
              );
            },
          ),
        DrawerItem(
          leading: Icon(
            Icons.receipt,
            color: Colors.white,
          ),
          title: Text(
            'Receipt',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
          ),
          onTap: () {
            CustomDrawer.of(context)!.close();
            // Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => CustomDrawer(
                  child: ReceiptScreen(),
                ),
              ),
            );
          },
        ),
        if (user.isCustomer)
          DrawerItem(
            leading: Icon(
              Icons.search,
              color: Colors.white,
            ),
            title: Text(
              'Search Jobs',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
            ),
            onTap: () {
              CustomDrawer.of(context)!.close();
              // Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => CustomDrawer(
                    child: SearchJobsScreen(),
                  ),
                ),
              );
            },
          ),
        if (!user.isCustomer)
          DrawerItem(
            leading: Icon(
              Icons.monetization_on,
              color: Colors.white,
            ),
            title: Text(
              'My Earnings',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
            ),
            onTap: () {
              CustomDrawer.of(context)!.close();
              // Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => CustomDrawer(
                    child: MyEarningsScreen(),
                  ),
                ),
              );
            },
          ),
        DrawerItem(
            leading: Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
            ),
            title: Text(
              'My Wallet',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
            ),
            onTap: () {
              CustomDrawer.of(context)!.close();
              // Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => CustomDrawer(
                    child: MyWalletScreen(),
                  ),
                ),
              );
            }),
        DrawerItem(
          leading: Icon(
            CupertinoIcons.profile_circled,
            color: Colors.white,
          ),
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
          ),
          onTap: () {
            CustomDrawer.of(context)!.close();
            user.isCustomer
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
        ),
        DrawerItem(
          leading: Icon(
            Icons.notifications_active,
            color: Colors.white,
          ),
          title: Text(
            'Notifications',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
          ),
          onTap: () {
            CustomDrawer.of(context)!.close();
            // Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => CustomDrawer(
                  child: NotificationsScreen(),
                ),
              ),
            );
          },
        ),
        DrawerItem(
          leading: Icon(
            Icons.speaker_group,
            color: Colors.white,
          ),
          title: Text(
            'Support',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
          ),
          onTap: () {
            CustomDrawer.of(context)!.close();
            // Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => CustomDrawer(
                  child: TicketsScreen(),
                ),
              ),
            );
          },
        ),
        if (!user.isCustomer)
          DrawerItem(
            leading: Icon(
              Icons.security,
              color: Colors.white,
            ),
            title: Text(
              'Change Password',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
            ),
            onTap: () {
              CustomDrawer.of(context)!.close();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => CustomDrawer(
                    child: ArtistChangePasswordScreen(),
                  ),
                ),
              );
            },
          ),
/*        DrawerItem(
          leading: Icon(
            Icons.attach_money,
            color: Colors.white,
          ),
          title: Text(
            'Refer & Earn',
            style: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.white,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => CustomDrawer(
                  child: DiscountReferalCodeScreen(),
                ),
              ),
            );
          },
        ),*/
        DrawerItem(
          leading: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          title: Text(
            'Log Out',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                ),
          ),
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
            Provider.of<Auth>(context, listen: false).logout();
          },
        ),
      ],
    );
  }
}

class DrawerItem extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Function onTap;
  DrawerItem({
    required this.leading,
    required this.title,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: leading,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: title,
            ),
          ],
        ),
      ),
    );
  }
}
