import 'package:clippy_flutter/arc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/homeScreens/user_recommendation.dart';
import 'package:my_tiffin/models/items.dart';

import '../asistantMethods/cartItemMethods.dart';

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
  // to store time the user viewd
  void logUserView() async {
    try {
      CollectionReference<Map<String, dynamic>> viewsCollection =
      FirebaseFirestore.instance.collection('views');

      // Log the user view by adding a document to the 'views' collection
      await viewsCollection.add({
        'user_id': sharedPreferences!.getString("uid"),
        'item_id': widget.model!.itemID,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print('View logged successfully.');
    } catch (e) {
      print('Error logging view: $e');
    }
  }
  //to store user interaction
  void saveUserInteraction(String action) async {
    try {
      CollectionReference<Map<String, dynamic>> userInteractions =
      FirebaseFirestore.instance.collection('user_interactions');

      await userInteractions
          .doc(sharedPreferences!.getString("uid"))
          .collection('interactions')
          .add({
        'item_id': widget.model!.itemID,
        'action': action,
        'timestamp': FieldValue.serverTimestamp(),

      });
    } catch (e) {
      print('Error saving user interaction: $e');
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
              const Text("Total: ",style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),),
              const SizedBox(
                width: 15,
              ),
              Text("Rs. ${(double.parse(widget.model!.itemPrice!) * number).toStringAsFixed(2)}",style: const TextStyle(
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
              itemIdList.contains(widget.model!.itemID)?
              Fluttertoast.showToast(msg: "Item Already In Cart"):
              // add to cart
              addItemToCart(widget.model!.itemID,context,number);
              // user_interaction
              saveUserInteraction("Added to Cart");

            },
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(Colors.green),
              padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 13,horizontal: 15,),),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
            ),
            icon: const Icon(CupertinoIcons.cart),
            label: const Text('Add to Cart', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,),),
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
                            Text("Rs. ${widget.model!.itemPrice!}",style: const TextStyle(
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
                              margin: const EdgeInsets.fromLTRB(0,0,5,0),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(onPressed: _decrement,
                                    icon: const Icon(CupertinoIcons.minus, color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  Text("$number",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  IconButton(onPressed: _increment,
                                    icon: const Icon(CupertinoIcons.plus, color: Colors.white,
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

                    ],
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0,5,5,5),
              child: Text("You might also like:",style: TextStyle(
                fontSize: 16,
                color: Colors.green
              ),),
            ),

            Container(
              height: 230,
                child: UserRecommendationScreen(model: widget.model)
            ),

          ],
        ),
      ),
      bottomNavigationBar: ItemBottomNavBar(),
    );
  }


}