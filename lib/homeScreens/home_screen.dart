import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/asistantMethods/cartItemCounter.dart';
import 'package:my_tiffin/homeScreens/cart_page.dart';
import 'package:my_tiffin/homeScreens/search_screen.dart';
import 'package:my_tiffin/widgets/appbar_widget.dart';
import 'package:my_tiffin/widgets/categories_widget.dart';
import 'package:my_tiffin/widgets/newest_item_widget.dart';
import 'package:my_tiffin/widgets/popular_item_widget.dart';
import 'package:my_tiffin/widgets/user_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

   const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const UserDrawer(),
      body: ListView(
        physics: const ClampingScrollPhysics(),
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
                     color: Colors.green,
                   ),
                   SizedBox(
                     height: 50,
                       width: 280,
                     child: Padding(padding: const EdgeInsets.symmetric(
                       horizontal: 15,
                     ),
                    child: TextFormField(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (c) => const SearchScreen()));
                      },
                      decoration: const InputDecoration(
                        hintText: 'What would you like to have?',
                        border: InputBorder.none,

                      ),
                    ),
                     ),
                   ),
                   const Icon(Icons.filter_list,
                   color: Colors.green,)
                 ],),
             ),
          ),
          ),
          //Category
          const Padding(
              padding:EdgeInsets.only(top: 15, left: 10),
             child: Text(
               'Category',
               style: TextStyle(
                 fontSize: 22,
                 fontWeight: FontWeight.bold,

               ),
             ),
          ),
          // categories widget
           CategoriesWidget(),
          // popular Items
          const Padding(
              padding: EdgeInsets.only(top: 20,left: 10),
          child: Text(
            "Popular",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          ),
          //popular items widget
           PopularItems(),
          //Newest items
          const Padding(
            padding: EdgeInsets.only(top: 15,left: 10),
            child: Text(
              "Newest",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          //Newest Item widget

          const SizedBox(
            height: 300,
              child: NewestItemWidget(),
          ),


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
        child: Stack(
          children: [
            FloatingActionButton(
              onPressed: () {
                // Push the CartPage onto the navigation stack.
                Navigator.push(context, MaterialPageRoute(builder: (c) => const CartPage()));
              },
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              child: const Icon(
                CupertinoIcons.cart,
                color: Colors.green,
                size: 30,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Center(
                // Center the text inside the badge.
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.green,
                  child: Consumer<CartItemCounter>(
                    builder: (context, counter, c) {
                      return Text(
                        counter.count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      );
                    },
                  )


                ),),
             ),
          ],
        )

      ),
    ) ;

  }
}
