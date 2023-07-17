import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/widgets/appbar_widget.dart';
import 'package:my_tiffin/widgets/staff_widget/staff_category_widget.dart';
import 'package:my_tiffin/widgets/staff_widget/staff_drawer.dart';

class StaffHomeScreen extends StatelessWidget {
  const StaffHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const StaffDrawer(),
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
                      width: 290,
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
          // popular Items
          const Padding(
            padding: EdgeInsets.only(top: 20,left: 10),
            child: Text(
              "Category",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
          //popular items widget
          SizedBox(height: 7,),

           const StaffCategoryItem(),
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
            // Navigator.push(context, MaterialPageRoute(builder: (c)=>const MenuUploadScreen()));

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
