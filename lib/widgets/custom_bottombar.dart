import 'package:flutter/material.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Plans/add_note_screen.dart';
import 'package:mealprep/screens/Plans/add_plan_screen.dart';
import 'package:mealprep/screens/Plans/pause.dart';
class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    Key? key,
    required this.selectedPlanId,
  }) : super(key: key);

  final int selectedPlanId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 70,
      margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
      decoration: BoxDecoration(
          color: ashwhite, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomNavItem(
            text: "Pause",
            onTap: () {
              Navigator.of(context)
                  .pushNamed(Pause.routeName, arguments: selectedPlanId);
            },
            icon: Icons.pause_outlined,
          ),
          BottomNavItem(
            text: "Switch",
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AddPlan.routeName, arguments: selectedPlanId);
            },
            icon: Icons.sync_alt,
          ),
          BottomNavItem(
            text: "Add note",
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AddNote.routeName, arguments: selectedPlanId);
            },
            icon: Icons.note_add_outlined,
          ),
          BottomNavItem(
            text: "Meals",
            onTap: () {
              Navigator.of(context)
                  .pushNamed('home', arguments: selectedPlanId);
            },
            icon: Icons.restaurant,
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  String text;
  IconData icon;
  VoidCallback onTap;
  BottomNavItem({required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.black,
                ),
          ),
        ],
      ),
    );
  }
}