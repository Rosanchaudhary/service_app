import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/providers/auth.dart';
import 'package:flutter_project/screens/widgets/custom_drawer.dart';
import 'package:flutter_project/screens/widgets/customer_change_password_widget.dart';
import 'package:flutter_project/screens/widgets/customer_set_address_widget.dart';
import 'package:flutter_project/screens/widgets/edit_customer_info_widget.dart';

import '../Global.dart';

class CustomerProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';
  const CustomerProfileScreen({Key? key}) : super(key: key);

  @override
  _CustomerProfileScreenState createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  late PickedFile _image;
  final ImagePicker _picker = ImagePicker();
  Future<void> _getImage(ImageSource source) async {
    final pickedImage = await _picker.getImage(source: source);

    setState(() {
      _image = pickedImage!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context).currentUser;
    return user == null
        ? const Scaffold()
        : Scaffold(
            // drawer: AppDrawer(),
            appBar: AppBar(
              title: const Text('Profile'),
              elevation: 0,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => CustomDrawer.of(context)!.open(),
                  );
                },
              ),
            ),
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CircleAvatar(
                          backgroundImage: _image == null
                              ? NetworkImage(user.image)
                              : FileImage(File(_image.path)) as ImageProvider,
                          radius: 60,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text(
                                  'Take Image from',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        _getImage(ImageSource.camera).then(
                                          (value) => Provider.of<Auth>(
                                            context,
                                            listen: false,
                                          ).uploadProfilePicture(_image.path),
                                        );
                                      },
                                      child: Text(
                                        'Camera',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(fontSize: 16),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        _getImage(ImageSource.gallery).then(
                                          (value) => Provider.of<Auth>(
                                            context,
                                            listen: false,
                                          ).uploadProfilePicture(_image.path),
                                        );
                                      },
                                      child: Text(
                                        'Gallery',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Text(
                              'Change',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(color: Colors.white),
                            ),
                            height: 28,
                            width: 68,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Personal Information',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isDismissible: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (_) {
                                return EditCustomerInfoWidget();
                              },
                            );
                          },
                          child: Icon(
                            Icons.edit,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Full Name',
                            style: Theme.of(context).textTheme.headline6!),
                        subtitle: Text(user.name),
                      ),
                      ListTile(
                        title: Text('Email',
                            style: Theme.of(context).textTheme.headline6!),
                        subtitle: Text(user.email),
                      ),
                      ListTile(
                        title: Text('Mobile Number',
                            style: Theme.of(context).textTheme.headline6!),
                        subtitle: Text(user.mobile),
                      ),
                      ListTile(
                        title: const Text('Gender'),
                        subtitle: Text(user.gender == '1' ? 'Male' : 'Female'),
                      ),
                      const Divider(),
                      ListTile(
                        title: Text(
                          'Set Address',
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isDismissible: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (_) {
                                return CustomerSetAddressWidget();
                              },
                            );
                          },
                          child: Icon(
                            Icons.edit,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('Your Address',
                            style: Theme.of(context).textTheme.headline6!),
                        subtitle: Text(user.address),
                      ),
                      ListTile(
                        title: Text('City',
                            style: Theme.of(context).textTheme.headline6!),
                        subtitle: Text(user.city),
                      ),
                      ListTile(
                        title: Text('Country',
                            style: Theme.of(context).textTheme.headline6!),
                        subtitle: Text(user.country),
                      ),
                      ListTile(
                        title: Text('Location',
                            style: Theme.of(context).textTheme.headline6!),
                        subtitle: Text(user.officeAddress),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 4.0,
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isDismissible: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (_) {
                                return CustomerChangePasswordWidget();
                              },
                            );
                          },
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 2.0,
                            child: Container(
                              child: ListTile(
                                leading: Icon(
                                  Icons.lock,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: Text(
                                  'Change Password',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          left: 8.0,
                          right: 8.0,
                          bottom: 8.0,
                        ),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 2.0,
                          child: Container(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed('/');
                                Provider.of<Auth>(context, listen: false)
                                    .logout();
                              },
                              leading: Icon(
                                Icons.logout,
                                color: Theme.of(context).primaryColor,
                              ),
                              title: Text(
                                'Log Out',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
