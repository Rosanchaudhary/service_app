import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/providers/customer.dart';
import 'package:flutter_project/screens/widgets/booking_list_item_widget.dart';
import 'package:flutter_project/screens/widgets/bottom_ff_navbar_widget.dart';
import 'package:flutter_project/screens/widgets/custom_drawer.dart';

class MyBookingScreen extends StatefulWidget {
  static const routeName = '/my-booking-screen';

  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  final _searchController = TextEditingController();
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Customer>(context, listen: false)
          .getMyCurrentBookingUser()
          .then((value) {
        setState(() {
          isInit = false;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bookings = Provider.of<Customer>(context).searchBooking;
    final searchContainer = Container(
      padding: const EdgeInsets.only(left: 8),
      margin: const EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 8,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      child: TextField(
        cursorColor: Colors.grey,
        style: TextStyle(
          fontSize: 18.0,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (text) {
          Provider.of<Customer>(context, listen: false).searchBookings(text);
        },
        maxLines: 1,
        autofocus: false,
        decoration: InputDecoration(
          icon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
          border: InputBorder.none,
          hintText: 'Search by Provider...',
          hintStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        controller: _searchController,
        onSubmitted: (_) {},
      ),
    );
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Mark Service App?'),
              content: const Text('Do you want to close Service App?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        // drawer: AppDrawer(),
        bottomNavigationBar: const BottomFFNavbarWidget(
          index: 1,
        ),
        appBar: AppBar(
          title: const Text('My Bookings'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: searchContainer,
          ),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => CustomDrawer.of(context)!.open(),
              );
            },
          ),
        ),
        body: isInit
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemBuilder: (ctx, i) {
                      return ChangeNotifierProvider.value(
                        value: bookings[i],
                        child: BookingListItemWidget(),
                      );
                    },
                    itemCount: bookings.length,
                  ),
                ),
              ),
      ),
    );
  }
}
