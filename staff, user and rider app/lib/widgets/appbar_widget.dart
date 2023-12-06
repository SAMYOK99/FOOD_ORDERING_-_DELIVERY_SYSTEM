import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/asistantMethods/cartItemMethods.dart';
import 'package:my_tiffin/widgets/user_drawer.dart';


class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical:  15,
          horizontal: 15,
        ),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           InkWell(
             onTap: (){
               Scaffold.of(context).openDrawer();
             },
             child: Container(
               padding: EdgeInsets.all(8),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(20),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.grey.withOpacity(0.5),
                     spreadRadius: 2,
                     blurRadius: 10,
                     offset: Offset(0,3),

                   )
                 ],
               ),
               child: Icon(
                 CupertinoIcons.bars,
               ),
             ),
           ),
           InkWell(
             onTap: (){
               clearCart(context);// Close the dialog

               // showDialog(
               //     context: context,
               //     builder: (BuildContext context) {
               //       return AlertDialog(
               //         title: Text("Confirm Delete"),
               //         content: Text("Are you sure you want to Clear the Cart?"),
               //         actions: [
               //           TextButton(
               //             child: Text("Cancel",
               //                 style: TextStyle(
               //                   color: Colors.green,
               //                 )),
               //             onPressed: () {
               //               Navigator.pop(context); // Close the dialog
               //             },
               //           ),
               //           TextButton(
               //             child: Text("Delete",
               //               style: TextStyle(
               //                 color: Colors.red,
               //               ),),
               //             onPressed: () {
               //               Navigator.pop(context);
               //             },
               //           ),
               //         ],
               //       );
               //     },
               //   );
             },

             child: Container(
               padding: EdgeInsets.all(8),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(20),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.grey.withOpacity(0.5),
                     spreadRadius: 2,
                     blurRadius: 10,
                     offset: Offset(0,3),

                   )
                 ],
               ),
               child: Icon(
                 Icons.cleaning_services,
               ),
             ),
           ),
         ],
       ),
    );
  }
}
