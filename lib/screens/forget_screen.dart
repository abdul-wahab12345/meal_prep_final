import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/login_screen.dart';
import 'package:mealprep/screens/registeration_screen.dart';
import 'package:mealprep/widgets/auth_button.dart';
import 'package:mealprep/widgets/input_feild.dart';
import 'package:mealprep/widgets/text_button.dart';

class ForgetScreen extends StatelessWidget {
  static const routeName='/forget';
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      backgroundColor: abackground,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              margin:EdgeInsets.only(top:height*12 ),
              height: height*16,
              width: height*16,
              child: Image.asset('assets/images/login_screen_image.png'),
            ), //Image Container

            Container(
              margin: EdgeInsets.only(bottom: height*3,top: height*5),
              child: Column(
                children: [
                  InputFeild('Email', height),
                  
                ],
              ),
            ),
            //TextFeild Container

            CustomButton(
              
              text: 'Reset Password',
              callback: (){},
            ),

            Container(
              margin: EdgeInsets.only(top: height*10 ,left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  AtextButton(text: 'Back',callBack: (){
                    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                  },),
                ],
              ),
            ), //Text button Container
          ],
        ),
      ),
    );
  }
}

