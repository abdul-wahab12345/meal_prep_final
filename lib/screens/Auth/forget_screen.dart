import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';

import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Auth/login_screen.dart';
import 'package:mealprep/screens/Auth/verification.dart';
import 'package:mealprep/widgets/adaptivedialog.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:mealprep/widgets/auth_button.dart';
import 'package:mealprep/widgets/input_feild.dart';
import 'package:mealprep/widgets/text_button.dart';
import 'package:provider/provider.dart';

class ForgetScreen extends StatefulWidget {
  static const routeName = '/forget';

  ForgetScreen({Key? key}) : super(key: key);

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String email = '';

  final emailController = TextEditingController();
  final _emailFocusNode = FocusNode();

  void resetPassword() async {
    
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
       
            await Provider.of<Auth>(context, listen: false)
                .resetPassword(emailController.text);

        Navigator.of(context).pushNamed(VerificationScreen.routeName,
            arguments: emailController.text);
        setState(() {
          isLoading = false;
        });
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        showDialog(
            context: context,
            builder: (ctx) => AdaptiveDiaglog(
                ctx: ctx,
                title: 'An error occurred',
                content: error.toString(),
                btnYes: 'Okay',
                yesPressed: () {
                  Navigator.of(context).pop();
                }));
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;

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
SizedBox(height: height*33,),
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(bottom: height * 3, top: height * 5),
                  child: InputFeild(
                    hinntText: 'Enter your email',
                    validatior: (String value) {
                      if (value.isEmpty) {
                        return "Please enter your email!";
                      }
                      if (!value.contains('@') || !value.contains('.com')) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                    inputController: emailController,
                    textInputAction: TextInputAction.done,
                    focusNode: _emailFocusNode,
                    saved: (value) {
                      email = value!;
                    },
                    submitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              ),
              //TextFeild Container

              isLoading
                  ? AdaptiveIndecator()
                  : CustomButton(
                      text: 'Reset Password',
                      callback: resetPassword,
                    ),

              Container(
                margin: EdgeInsets.only(top: height * 3, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AtextButton(
                      text: 'Back',
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
