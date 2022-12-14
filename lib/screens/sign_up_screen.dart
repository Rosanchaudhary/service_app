import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/providers/auth.dart';
import 'package:flutter_project/screens/sign_in_screen.dart';
import 'package:flutter_project/screens/terms_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up-screen'; 
  final bool isCustomer;
  const SignUpScreen({Key? key, required this.isCustomer}) : super(key: key);
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _codeController = TextEditingController();
  bool _visibility = false;
  bool _visibilityConfirm = false;
  bool _isChecked = false;
  late bool isIos;
  final Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };
  String _referralCode = "";

  Future<void> _showErrorDialog(String message) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _showRegisteredDialog(String message) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Registration almost done!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext ctx) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    if (!_isChecked) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
            'Please Agree with our Terms & Condition',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
      return;
    }
    _formKey.currentState!.save();
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).signup(
        name: _authData['name']!,
        email: _authData['email']!,
        password: _authData['password']!,
        deviceType: isIos ? 'IOS' : 'ANDROID',
        isCustomer: widget.isCustomer, 
        referralCode: _referralCode,
      );
    } catch (error) {
      String errorMessage;
      if (error.toString() == 'User already registered') {
        errorMessage = 'User already registered.';
      } else {
        errorMessage = 'Something went wrong. Please try again later.';
      }
      await _showErrorDialog(errorMessage);
      print(errorMessage);
      print('$error');
    }
    await _showRegisteredDialog(
        'Please check your email to complete the registration!');
    setState(() {
      Navigator.of(context).pop();
      // Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    isIos = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Builder(
          builder: (builderContext) => SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      height: 250,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Image.asset(
                        'assets/images/login_up.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            top: 4.0,
                            bottom: 4.0,
                          ),
                          child: TextFormField(
                            controller: _nameController,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 3) {
                                return 'Please enter a valid Name!';
                              }
                            },
                            onSaved: (value) {
                              _authData['name'] = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            top: 4.0,
                            bottom: 4.0,
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 5) {
                                return 'Please enter a valid Email!';
                              }
                            },
                            onSaved: (value) {
                              _authData['email'] = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            top: 4.0,
                            bottom: 4.0,
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: !_visibility,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 5) {
                                return 'Please enter a valid password!';
                              }
                            },
                            onSaved: (value) {
                              _authData['password'] = value!;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _visibility
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _visibility = !_visibility;
                                  });
                                },
                              ),
                              labelText: 'Password',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            obscureText: !_visibilityConfirm,
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _visibilityConfirm
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _visibilityConfirm = !_visibilityConfirm;
                                  });
                                },
                              ),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            top: 4.0,
                            bottom: 4.0,
                          ),
                          child: TextFormField(
                            controller: _codeController,
                            validator: (value) {
                              /*if (!value.isEmpty || value.length > 5) {
                                return 'Please enter a valid code!';
                              }*/
                            },
                            onSaved: (value) {
                              _referralCode = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Referral code',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CheckboxListTile(
                    title: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'By Clicking You have read and agreed with our ',
                            style: Theme.of(context).textTheme.headline6!,
                          ),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(TermsScreen.routeName);
                              },
                              child: Text(
                                'Terms & Condition',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    value: _isChecked,
                    onChanged: (newValue) {
                      setState(() {
                        _isChecked = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 4.0,
                      bottom: 4.0,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0),
                        // textColor:
                        // Theme.of(context).primaryTextTheme.button!.color,
                      ),
                      child: Center(
                        child: Container(
                          height: 30,
                          alignment: Alignment.center,
                          child: Text(
                            'Sign Up',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        await _submit(builderContext);
                      },
                    ),
                  ),
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                        //materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        //textColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text('Login INSTEAD'),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => SignInScreen(
                              isCustomer: widget.isCustomer,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
