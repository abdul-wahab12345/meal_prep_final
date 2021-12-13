import 'package:flutter/material.dart';
import 'package:mealprep/Models/products.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/profile_screen.dart';
import 'package:mealprep/screens/variations_plan_screen.dart';

class AddPlan extends StatelessWidget {
  static const routeName = '/addPlan';
  const AddPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    var product = Products();
    List<Product> prod = product.products;

    var currentOrientation = Orientation.landscape;
    var _appBar = AppBar(
      backgroundColor: aPrimary,
      title: const Text("Add Plan"),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProfileScreen.routeName);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              child: Image.asset('assets/images/person.png'),
            ),
          ),
        )
      ],
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar,
      //bottomNavigationBar: bottomBar,
      
      body: Center(
        heightFactor: 1,
        child: Container(
          width: currentOrientation == Orientation.landscape
              ? 550
              : double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: currentOrientation == Orientation.landscape
                      ? height * 70
                      : height * 78,
                  child: ListView.builder(
                    itemCount: prod.length,
                    itemBuilder: (ctx, index) => GestureDetector(
                     onTap: (){
                       Navigator.of(context).pushNamed(VariationsScreen.routeName,arguments: prod[index].id);
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
                                          SizedBox(height: 20,),
                                          Text('Delivery Date',style: Theme.of(context).textTheme.bodyText2,),
                                          SizedBox(height: 1.5,),
                                  Text(prod[index].deliveryDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!),
                                  SizedBox(height: 25,),
                                  Text(
                                    prod[index].price,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.green),
                                  ),
                                ],
                              ),
                            ), //ContentConatiner
                            Container(
                              width: 100,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Image.network(prod[index].imageUrl,
                                  fit: BoxFit.cover),
                            ), //imageContainer
                          ],
                        ),
                      ),
                    ),
                  ),
                ), //Listview end
              ],
            ),
          ),
        ),
      ),
    );
  }
}
