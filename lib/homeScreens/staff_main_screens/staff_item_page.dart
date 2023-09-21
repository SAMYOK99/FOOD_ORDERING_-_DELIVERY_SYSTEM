import 'package:clippy_flutter/arc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_tiffin/widgets/appbar_widget.dart';
// import 'package:my_tiffin/widgets/item_bottom_navbar.dart';
import 'package:my_tiffin/widgets/user_drawer.dart';

import '../../widgets/cart_bottom_navbar.dart';
class StaffItemPage extends StatelessWidget {
  const StaffItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.green
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(padding: const EdgeInsets.only(top:5),
      child: ListView(
        children:  [
          Padding(padding: const EdgeInsets.all(16),
          child: Image.asset("images/burger.png",
          height: 300,
            // width: double.infinity,
            // width: 100,
          ),
          ),
          Arc(
            edge: Edge.TOP,
            arcType: ArcType.CONVEY,
            height: 30,
            child: Container(
              width: double.infinity ,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(padding: const EdgeInsets.only(top: 60, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 18,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                            itemBuilder: (context,_)=>const Icon(
                              Icons.star,
                              color: Colors.green,

                            ),
                            onRatingUpdate: (index){},),
                          const Text("\$10",style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),),
                    Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                        children: [
                          const Text("Hot Pizza",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          Container(
                            width: 90,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(CupertinoIcons.minus, color: Colors.white,
                                size: 20,
                                ), 
                                Text("1",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),),
                                Icon(CupertinoIcons.plus, color: Colors.white,
                                size: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 10,),child: Text('jljfajfdaoidjfaidfjaoidfjadfaidf',style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                    ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween    ,
                        children: [
                          Text('Delivery Time:',
                            style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.justify,
                    ),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Icon(CupertinoIcons.clock,color: Colors.green,),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Text('30 Minutes',
                      style: TextStyle(
                        fontSize: 16,
                      ),

                    ),

                  ],
                ),
              ),
            ),
          ),

        ],
      ),
      ),
      bottomNavigationBar: CartBottomNavBar(),
    );
  }
}
