import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/widgets/appbar_widget.dart';
import 'package:my_tiffin/widgets/cart_bottom_navbar.dart';
import 'package:my_tiffin/widgets/user_drawer.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppBarWidget(),
                  const Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                        left: 10,
                      ),
                    child: Text(
                      "Order List",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  //Item
                  Padding(padding: const EdgeInsets.symmetric(vertical: 9),
                  child: Container(
                    width: 380,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: const Offset(0,3),

                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset("images/burger.png",
                          height: 80,
                          width: 150,
                          ),
                        ),
                        Container(
                         width: 190,
                         child: const Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                              Text('Hot Burger',
                               style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                               ),),
                              Text('Taste Our Hot Burger',
                               style: TextStyle(
                                 fontSize: 14,
                                 fontWeight: FontWeight.bold,
                               ),),
                              Text("\$10",
                               style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.green,
                               ),),
                           ],
                         ),
                        ),
                        Padding(padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.all((5)),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),

                          ) ,
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(CupertinoIcons.minus,
                              color: Colors.white,

                              ),
                              Text("2",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,

                                ),
                              ),

                              Icon(CupertinoIcons.minus,
                                color: Colors.white,

                              ),
                            ],
                          ),
                        ),)


                      ],
                    ),
                  ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Container(
                      width: 380,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0,3),

                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Image.asset("images/burger.png",
                              height: 80,
                              width: 150,
                            ),
                          ),
                          Container(
                            width: 190,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Hot Burger',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                Text('Taste Our Hot Burger',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                Text("\$10",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),),
                              ],
                            ),
                          ),
                          Padding(padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              padding: const EdgeInsets.all((5)),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),

                              ) ,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(CupertinoIcons.minus,
                                    color: Colors.white,

                                  ),
                                  Text("2",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,

                                    ),
                                  ),

                                  Icon(CupertinoIcons.minus,
                                    color: Colors.white,

                                  ),
                                ],
                              ),
                            ),)


                        ],
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 9),
                    child: Container(
                      width: 380,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0,3),

                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Image.asset("images/burger.png",
                              height: 80,
                              width: 150,
                            ),
                          ),
                          Container(
                            width: 190,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Hot Burger',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                Text('Taste Our Hot Burger',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                Text("\$10",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),),
                              ],
                            ),
                          ),
                          Padding(padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              padding: const EdgeInsets.all((5)),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),

                              ) ,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(CupertinoIcons.minus,
                                    color: Colors.white,

                                  ),
                                  Text("2",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,

                                    ),
                                  ),

                                  Icon(CupertinoIcons.minus,
                                    color: Colors.white,

                                  ),
                                ],
                              ),
                            ),)


                        ],
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                       borderRadius: BorderRadius.circular(10),
                      boxShadow:[ BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0,3),
                      ),
                    ]),
                    child: const Column(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Items:",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text("10",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,

                              ),
                            ),
                          ],
                        ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sub-Total:",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text("10",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,

                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Delivery Fee:",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text("10",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,

                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                        ),

                        Padding(padding: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total:",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("10",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ),
                ],
              ),
            ),

          )
        ],
      ),
      drawer: const UserDrawer(),
      bottomNavigationBar: const CartBottomNavBar(),
    );
  }
}
