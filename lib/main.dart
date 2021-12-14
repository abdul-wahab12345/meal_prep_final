import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/Models/products.dart';
import 'package:mealprep/screens/add_plan_screen.dart';
import 'package:mealprep/screens/check_out.dart';
import 'package:mealprep/screens/cites_screen.dart';
import 'package:mealprep/screens/forget_screen.dart';
import 'package:mealprep/screens/login_screen.dart';
import 'package:mealprep/screens/meal_details_screen.dart';
import 'package:mealprep/screens/plans_screen.dart';
import 'package:mealprep/screens/profile_screen.dart';
import 'package:mealprep/screens/registeration_screen.dart';
import 'package:mealprep/screens/splash_screen.dart';
import 'package:mealprep/screens/user_meals_screen.dart';
import 'package:mealprep/screens/variations_plan_screen.dart';

import 'package:provider/provider.dart';

import 'Models/meals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, UserMealsData>(
          create: (_) => UserMealsData(0,'',[]),
          update: (ctx, auth, previousData) => UserMealsData(
            auth.id as int,
            auth.websiteUrl as String,
            previousData==null?[]:previousData.userMeals,
            
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meal Prep',
        theme: ThemeData(fontFamily: 'IBM').copyWith(
          textTheme: const TextTheme().copyWith(
            headline6: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.75,
              fontSize: 20,
              // height: 19.88,
            ),
            headline5: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
            bodyText2: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 13,
              letterSpacing: 1.3,
            ),
            caption: const TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 9,
              letterSpacing: 2,
            ),
          ),
        ),
        routes: {
          '/': (ctx) => AddPlan(),
          "home": (ctx) => UserMealsScreen(),
          MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          ForgetScreen.routeName: (ctx) => ForgetScreen(),
          CityScreen.routeName: (ctx) => CityScreen(),
          PlanScreen.routeName:(ctx)=>PlanScreen(),
          AddPlan.routeName:(ctx)=>AddPlan(),
          VariationsScreen.routeName:(ctx)=>VariationsScreen(),
          CheckOut.routeName:(ctx)=>CheckOut(),
          
        },
        //home: RegisterScreen(),
      ),
    );
  }
}
