import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/screens/Auth/login_screen.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:mealprep/widgets/adaptivedialog.dart';
import 'package:mealprep/widgets/auth_button.dart';
import 'package:mealprep/widgets/input_feild.dart';
import 'package:mealprep/widgets/text_button.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/changePass';
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var newpassController = TextEditingController();
  var confirmpassController = TextEditingController();
  Map<String, dynamic> data = {};

  void tryChangePass() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await Provider.of<Auth>(context, listen: false)
          .forgetChangePassword(
              data['email'], data['code'], newpassController.text)
          .catchError((error) {
        setState(() {
          isLoading = false;
        });
        showDialog(
            context: context,
            builder: (ctx) => AdaptiveDiaglog(
                ctx: ctx,
                title: 'An Error Occurred',
                content: error.toString(),
                btnYes: 'Okay',
                yesPressed: () {
                  Navigator.of(context).pop();
                }));
      });
      setState(() {
        isLoading = false;
      });
      showDialog(
          context: context,
          builder: (ctx) => AdaptiveDiaglog(
              ctx: ctx,
              title: "Password Changed",
              content: 'Your password has been changed',
              btnYes: ('Okay'),
              yesPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;

    data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: abackground,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 12),
                height: height * 16,
                width: height * 16,
                child: Image.asset('assets/images/login_screen_image.png'),
              ), //Image Container

              Container(
                margin: EdgeInsets.only(bottom: height * 3, top: height * 5),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputFeild(
                        secure: true,
                        hinntText: 'New password',
                        validatior: (String value) {
                          if (value.isEmpty) {
                            return "Enter new password";
                          }
                          if (value.length <= 6) {
                            return 'Must have 6 characters';
                          }

                          return null;
                        },
                        inputController: newpassController,
                      ),
                      InputFeild(
                        secure: true,
                        hinntText: 'Confirm Password',
                        validatior: (String value) {
                          if (value.isEmpty) {
                            return "Enter password again";
                          }
                          if (confirmpassController.text !=
                              newpassController.text) {
                            return "Password did not match";
                          }

                          return null;
                        },
                        inputController: confirmpassController,
                      ),
                    ],
                  ),
                ),
              ),

              //TextFeild Container

              isLoading
                  ? AdaptiveIndecator()
                  : CustomButton(
                      text: 'Change Password',
                      callback: tryChangePass,
                    ),

              Container(
                margin: EdgeInsets.only(top: height * 7, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AtextButton(
                      text: 'Go to Login',
                      callBack: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
                      },
                    ),
                  ],
                ),
              ), //Text button Container
            ],
          ),
        ),
      ),
    );
  }
}
