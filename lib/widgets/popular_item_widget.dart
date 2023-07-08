import 'package:flutter/material.dart';

class PopularItems extends StatelessWidget {
  const PopularItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
        child: Row(
          children: [

            //single item
            Padding(
               padding: const EdgeInsets.symmetric(horizontal: 7),
           child: Container(
             width: 170,
             height: 225,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(10),
               boxShadow: [
                 BoxShadow(
                   color: Colors.grey.withOpacity(0.5),
                   spreadRadius: 2,
                   blurRadius: 10,
                   offset: const Offset(0,3),

                 )
               ],
             ),
             child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
             child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Container(
                   alignment: Alignment.center,
                   child: Image.asset("images/burger.png"),
                 ),
                 const Text('Hot Burger',
                   style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                   ),),
                 const SizedBox(height: 4,),
                 const Text('Taste our Hot Burger',
                   style: TextStyle(
                     fontSize: 15,
                     // fontWeight: FontWeight.bold,
                   ),),
                 const SizedBox(height: 12,),
                 const Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("\$10",style: TextStyle(
                       fontSize: 17,
                       color: Colors.green,
                       fontWeight:  FontWeight.bold,
                     ),),
                     Icon(Icons.favorite_border,
                     color: Colors.green,
                     size: 26,
                     ),
                   ],
                 ),


               ],
             ),
             ),
           ),
           ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: 170,
                height: 225,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0,3),

                    )
                  ],
                ),
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset("images/burger.png"),
                      ),
                      const Text('Hot Burger',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                      const SizedBox(height: 4,),
                      const Text('Taste our Hot Burger',
                        style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      const SizedBox(height: 12,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("\$10",style: TextStyle(
                            fontSize: 17,
                            color: Colors.green,
                            fontWeight:  FontWeight.bold,
                          ),),
                          Icon(Icons.favorite_border,
                            color: Colors.green,
                            size: 26,
                          ),
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: 170,
                height: 225,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0,3),

                    )
                  ],
                ),
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset("images/burger.png"),
                      ),
                      const Text('Hot Burger',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                      const SizedBox(height: 4,),
                      const Text('Taste our Hot Burger',
                        style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      const SizedBox(height: 12,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("\$10",style: TextStyle(
                            fontSize: 17,
                            color: Colors.green,
                            fontWeight:  FontWeight.bold,
                          ),),
                          Icon(Icons.favorite_border,
                            color: Colors.green,
                            size: 26,
                          ),
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: 170,
                height: 225,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0,3),

                    )
                  ],
                ),
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset("images/burger.png"),
                      ),
                      const Text('Hot Burger',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                      const SizedBox(height: 4,),
                      const Text('Taste our Hot Burger',
                        style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      const SizedBox(height: 12,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("\$10",style: TextStyle(
                            fontSize: 17,
                            color: Colors.green,
                            fontWeight:  FontWeight.bold,
                          ),),
                          Icon(Icons.favorite_border,
                            color: Colors.green,
                            size: 26,
                          ),
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: 170,
                height: 225,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0,3),

                    )
                  ],
                ),
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset("images/burger.png"),
                      ),
                      const Text('Hot Burger',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                      const SizedBox(height: 4,),
                      const Text('Taste our Hot Burger',
                        style: TextStyle(
                          fontSize: 15,
                          // fontWeight: FontWeight.bold,
                        ),),
                      const SizedBox(height: 12,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("\$10",style: TextStyle(
                            fontSize: 17,
                            color: Colors.green,
                            fontWeight:  FontWeight.bold,
                          ),),
                          Icon(Icons.favorite_border,
                            color: Colors.green,
                            size: 26,
                          ),
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }
}
