import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NewestItemWidget extends StatelessWidget {
  const NewestItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
child: Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10 ),
 child: Column(
   children: [
     //for(int i = 0;i<10;i++)
     //single item
     Padding(padding: const EdgeInsets.symmetric(vertical: 10),
     child: Container(
       width: 380,
       height: 150,
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
           InkWell(
             onTap: (){},
             child: Container(
               alignment: Alignment.bottomCenter,
               child: Image.asset(
                 "images/burger.png",
                 height: 120,
                 width: 150,
               ),
             ),
           ),
           Container(
             width: 190,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 const Text("Hot Burger",style: TextStyle(
                   fontSize: 22,
                   fontWeight: FontWeight.bold,
                 ),),
                 const Text("Taset our hot burger",style: TextStyle(
                   fontSize: 16,
                   fontWeight: FontWeight.bold,
                 ),),
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
                   fontSize: 17,
                   color: Colors.green,
                   fontWeight:  FontWeight.bold,
                 ),),
               ],
             ),
           ),
           const Padding(
             padding: EdgeInsets.symmetric(vertical: 10),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Icon(Icons.favorite_border,
                   color: Colors.green,
                   size: 26,
                 ),
                 Icon(
                 CupertinoIcons.cart,
                   color: Colors.green,
                   size: 26,
                 ),
               ],
             ),
           ),
         ],
       ),
     ),
     ),
     Padding(padding: const EdgeInsets.symmetric(vertical: 10),
       child: Container(
         width: 380,
         height: 150,
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
             InkWell(
               onTap: (){},
               child: Container(
                 alignment: Alignment.bottomCenter,
                 child: Image.asset(
                   "images/burger.png",
                   height: 120,
                   width: 150,
                 ),
               ),
             ),
             Container(
               width: 190,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   const Text("Hot Burger",style: TextStyle(
                     fontSize: 22,
                     fontWeight: FontWeight.bold,
                   ),),
                   const Text("Taset our hot burger",style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                   ),),
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
                     fontSize: 17,
                     color: Colors.green,
                     fontWeight:  FontWeight.bold,
                   ),),
                 ],
               ),
             ),
             const Padding(
               padding: EdgeInsets.symmetric(vertical: 10),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Icon(Icons.favorite_border,
                     color: Colors.green,
                     size: 26,
                   ),
                   Icon(
                     CupertinoIcons.cart,
                     color: Colors.green,
                     size: 26,
                   ),
                 ],
               ),
             ),
           ],
         ),
       ),
     ),
     Padding(padding: const EdgeInsets.symmetric(vertical: 10),
       child: Container(
         width: 380,
         height: 150,
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
             InkWell(
               onTap: (){},
               child: Container(
                 alignment: Alignment.bottomCenter,
                 child: Image.asset(
                   "images/burger.png",
                   height: 120,
                   width: 150,
                 ),
               ),
             ),
             Container(
               width: 190,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   const Text("Hot Burger",style: TextStyle(
                     fontSize: 22,
                     fontWeight: FontWeight.bold,
                   ),),
                   const Text("Taset our hot burger",style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                   ),),
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
                     fontSize: 17,
                     color: Colors.green,
                     fontWeight:  FontWeight.bold,
                   ),),
                 ],
               ),
             ),
             const Padding(
               padding: EdgeInsets.symmetric(vertical: 10),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Icon(Icons.favorite_border,
                     color: Colors.green,
                     size: 26,
                   ),
                   Icon(
                     CupertinoIcons.cart,
                     color: Colors.green,
                     size: 26,
                   ),
                 ],
               ),
             ),
           ],
         ),
       ),
     ),
     Padding(padding: const EdgeInsets.symmetric(vertical: 10),
       child: Container(
         width: 380,
         height: 150,
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
             InkWell(
               onTap: (){},
               child: Container(
                 alignment: Alignment.bottomCenter,
                 child: Image.asset(
                   "images/burger.png",
                   height: 120,
                   width: 150,
                 ),
               ),
             ),
             Container(
               width: 190,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   const Text("Hot Burger",style: TextStyle(
                     fontSize: 22,
                     fontWeight: FontWeight.bold,
                   ),),
                   const Text("Taset our hot burger",style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                   ),),
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
                     fontSize: 17,
                     color: Colors.green,
                     fontWeight:  FontWeight.bold,
                   ),),
                 ],
               ),
             ),
             const Padding(
               padding: EdgeInsets.symmetric(vertical: 10),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Icon(Icons.favorite_border,
                     color: Colors.green,
                     size: 26,
                   ),
                   Icon(
                     CupertinoIcons.cart,
                     color: Colors.green,
                     size: 26,
                   ),
                 ],
               ),
             ),
           ],
         ),
       ),
     ),
     Padding(padding: const EdgeInsets.symmetric(vertical: 10),
       child: Container(
         width: 380,
         height: 150,
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
             InkWell(
               onTap: (){},
               child: Container(
                 alignment: Alignment.bottomCenter,
                 child: Image.asset(
                   "images/burger.png",
                   height: 120,
                   width: 150,
                 ),
               ),
             ),
             Container(
               width: 190,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   const Text("Hot Burger",style: TextStyle(
                     fontSize: 22,
                     fontWeight: FontWeight.bold,
                   ),),
                   const Text("Taset our hot burger",style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                   ),),
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
                     fontSize: 17,
                     color: Colors.green,
                     fontWeight:  FontWeight.bold,
                   ),),
                 ],
               ),
             ),
             const Padding(
               padding: EdgeInsets.symmetric(vertical: 10),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Icon(Icons.favorite_border,
                     color: Colors.green,
                     size: 26,
                   ),
                   Icon(
                     CupertinoIcons.cart,
                     color: Colors.green,
                     size: 26,
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
    );
  }
}
