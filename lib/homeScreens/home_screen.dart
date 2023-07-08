 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/widgets/appbar_widget.dart';
import 'package:my_tiffin/widgets/categories_widget.dart';
import 'package:my_tiffin/widgets/newest_item_widget.dart';
import 'package:my_tiffin/widgets/popular_item_widget.dart';
import 'package:my_tiffin/widgets/user_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const UserDrawer(),
      body: ListView(
        children: [
          //custom App Bar widget
          const AppBarWidget(),
          //Searching
          Padding(padding: const EdgeInsets.symmetric(
              vertical: 10,
          horizontal: 15,
          ),
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                   color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0,3),

                )
              ]
            ),
             child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
               child: Row(
                 children: [
                   const Icon(
                       CupertinoIcons.search,
                     color: Colors.red,
                   ),
                   Container(
                     height: 50,
                       width: 300,
                     child: Padding(padding: const EdgeInsets.symmetric(
                       horizontal: 15,
                     ),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'What would you like to have?',
                        border: InputBorder.none,

                      ),
                    ),
                     ),
                   ),
                   const Icon(Icons.filter_list),
                 ],),
             ),
          ),
          ),
          //Category
          const Padding(
              padding:EdgeInsets.only(top: 20, left: 10),
             child: Text(
               'Category',
               style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.bold,

               ),
             ),
          ),
          // categories widget
          const CategoriesWidget(),
          // popular Items
          const Padding(
              padding: EdgeInsets.only(top: 20,left: 10),
          child: Text(
            "Popular",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          ),
          //popular items widget
          const PopularItems(),
          //Newest items
          const Padding(
            padding: EdgeInsets.only(top: 20,left: 10),
            child: Text(
              "Newest",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          //Newest Item widget
          const NewestItemWidget(),


        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0,3),

            )
          ],
        ),
        child: FloatingActionButton(
          onPressed: (){

          },
          backgroundColor: Colors.white,
          child: const Icon( CupertinoIcons.cart,
            color: Colors.green,
            size: 30,
          ),
        ),

      ),
    ) ;

  }
}
