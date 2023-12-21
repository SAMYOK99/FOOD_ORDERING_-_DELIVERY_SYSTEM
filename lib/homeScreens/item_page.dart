import 'package:clippy_flutter/arc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_tiffin/asistantMethods/cartItemCounter.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:provider/provider.dart';

import '../asistantMethods/cartItemMethods.dart';
import '../globalVariables/globleVariable.dart';
class ItemPage extends StatefulWidget {
   Items? model;
ItemPage({super.key, this.model});

  @override
  State<ItemPage> createState() => _ItemPageState();
}


class _ItemPageState extends State<ItemPage> {

  int number = 1;
  _increment(){
    setState(() {
      number++;
    });

  }
  _decrement(){
    if(number>1){
      setState(() {
        number--;
      });
    }
  }

  ItemBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children:[
              Text("Total: ",style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(
                width: 15,
              ),
              Text("\$10",style: TextStyle(
                fontSize: 19,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),),
            ],
          ),
          ElevatedButton.icon(
            onPressed: (){
              // if already exist
              List<String> itemIdList =  separateItemIds();
              itemIdList.contains(widget.model!.itemID!)?
              Fluttertoast.showToast(msg: "Item Already In Cart"):
              // add to cart
              addItemToCart(widget.model!.itemID,context,number);


            },
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(Colors.green),
              padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 13,horizontal: 15,),),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
            ),
            icon: Icon(CupertinoIcons.cart),
            label: Text('Add to Cart', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,),),
          )],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.green,
          size: 33,

        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(padding: const EdgeInsets.only(top:5),
      child: ListView(
        children:  [
          Padding(padding: const EdgeInsets.all(16),
          child:  Image.network(
            widget.model!.thumbnailUrl!,
            height: 300,
          ),
          // Image.asset("images/burger.png",
          // height: 300,
            // width: double.infinity,
            // width: 100,
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
                           Text("\$${widget.model!.itemPrice!}",style: const TextStyle(
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
                           Text(widget.model!.itemTitle!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          Container(
                            width: 120,
                            height: 50,
                            margin: EdgeInsets.fromLTRB(0,0,10,0),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(onPressed: _decrement,
                                    icon: Icon(CupertinoIcons.minus, color: Colors.white,
                                      size: 20,
                                    ),
                                ),
                                Text("$number",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),),
                                IconButton(onPressed: _increment,
                                  icon: Icon(CupertinoIcons.plus, color: Colors.white,
                                  size: 20,
                                ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                     Padding(padding: const EdgeInsets.symmetric(vertical: 10,),
                       child: Text(widget.model!.description!,
                         style: const TextStyle(
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
      bottomNavigationBar: ItemBottomNavBar(),
    );
  }


}
