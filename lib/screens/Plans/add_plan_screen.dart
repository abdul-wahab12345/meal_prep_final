import 'package:flutter/material.dart';
import 'package:mealprep/Models/products.dart';
import 'package:mealprep/Models/user.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';

import 'package:mealprep/screens/Plans/variations_plan_screen.dart';
import 'package:mealprep/widgets/adaptivedialog.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:provider/provider.dart';

class AddPlan extends StatefulWidget {
  static const routeName = '/addPlan';
  const AddPlan({Key? key}) : super(key: key);

  @override
  State<AddPlan> createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
  List<Product> prod = [];

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      Provider.of<Products>(context, listen: false)
          .fetchAndSetProducts()
          .catchError((error) {
        showDialog(
            context: context,
            builder: (ctx) => AdaptiveDiaglog(
                ctx: ctx,
                title: 'Error occurred',
                content: error.toString(),
                btnYes: 'Okay',
                yesPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    //isLoading=false;
                  });
                }));
      });
    });

    // TODO: implement initState
    super.initState();
  }

  Map<String, int> args = {
    'prodID': 0,
    'planId': 0,
  };

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;

    var data = ModalRoute.of(context)!.settings.arguments as int;
    int subId = 0;
    if (data != 0) {
      subId = data;
    }
    print(subId);

    prod = Provider.of<Products>(context).products;
    var user = Provider.of<UserData>(context).user;
    var currentOrientation = Orientation.landscape;
    var _appBar = AppBar(
      backgroundColor: aPrimary,
      title: const Text("Add Plan"),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PlanScreen.routeName, arguments: 2);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              child: user != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        user.imageUrl,
                        height: 40,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  : Image.asset('assets/images/person.png'),
            ),
          ),
        )
      ],
    );
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: _appBar,
        //bottomNavigationBar: bottomBar,

        body: prod.isEmpty
            ? AdaptiveIndecator()
            : Center(
                heightFactor: 1,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: ListView.builder(
                    itemCount: prod.length,
                    itemBuilder: (ctx, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            VariationsScreen.routeName,
                            arguments: <String, int>{
                              'prodId': prod[index].id,
                              'subId': subId as int,
                            });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 17,
                        ),
                        decoration: BoxDecoration(
                          color: aPrimary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: width * 5,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 19,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(prod[index].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Delivery Date',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  const SizedBox(
                                    height: 1.5,
                                  ),
                                  Text(prod[index].deliveryDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'Starting \$${prod[index].price}/week',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.green),
                                  ),
                                ],
                              ),
                            ), //ContentConatiner
                            Center(
                              child: Container(
                                width: 120,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                margin: const EdgeInsets.only(right: 15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(prod[index].imageUrl,
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ), //imageContainer
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ));
  }
}
