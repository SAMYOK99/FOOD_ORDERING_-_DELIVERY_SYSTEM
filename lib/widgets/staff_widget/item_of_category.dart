import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/staff_item_page.dart';

import '../../uploadScreen/item_upload_screen.dart';

class CategoryItemWidget extends StatefulWidget {
  final ValueChanged<bool> onButtonClicked;
  CategoryItemWidget({required this.onButtonClicked});

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  bool isButtonClicked= false;
  @override
  void handleButtonClicked(bool isClicked) {
    if (isClicked) {
      // Button inside MenuUploadScreen is clicked
      setState(() {
        isButtonClicked = isClicked;
      });
    }
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10 ),
        child: Column(
          children: [
            //for(int i = 0;i<10;i++)
            //single item
            Padding(padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height* 0.2,
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
                child: Column(
                  children: [
                    Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (c)=>const StaffItemPage()));
                        },
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
                            const Text("Taste",style: TextStyle(
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

                    ],
                  ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Row(
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
                  ]
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height* 0.2,
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
                child: Column(
                  children: [
                    Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (c)=>const StaffItemPage()));
                        },
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
                            const Text("Taste",style: TextStyle(
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

                    ],
                  ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Row(
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
                  ]
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height* 0.2,
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
                child: Column(
                  children: [
                    Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (c)=>const StaffItemPage()));
                        },
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
                            const Text("Taste",style: TextStyle(
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

                    ],
                  ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Row(
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
                  ]
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height* 0.2,
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
                child: Column(
                  children: [
                    Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (c)=>const StaffItemPage()));
                        },
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
                            const Text("Taste",style: TextStyle(
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

                    ],
                  ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Row(
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
                  ]
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height* 0.2,
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
                child: Column(
                  children: [
                    Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (c)=>const StaffItemPage()));
                        },
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
                            const Text("Taste",style: TextStyle(
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

                    ],
                  ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Row(
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
                  ]
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 15, 40),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor:Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      child: const Text(
                        'Add Item',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,

                        ),
                      ),
                      onPressed: ()=>{
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemUploadScreen(onButtonClicked:  handleButtonClicked,))),
                      widget.onButtonClicked(true),

                  }
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor:Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal:40,vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,

                        ),
                      ),
                      onPressed: ()=>{

                      }
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50,),
          ],
        ),

      ),
    );
  }
}
