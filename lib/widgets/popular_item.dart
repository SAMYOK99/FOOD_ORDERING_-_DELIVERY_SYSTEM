import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/homeScreens/item_page.dart';
import 'package:my_tiffin/models/items.dart';
class PopularShownItems extends StatefulWidget {
  Items? model;
  BuildContext? context;

  PopularShownItems({this.model, this.context});
  @override
  State<PopularShownItems> createState() => _PopularShownItemsState();
}

class _PopularShownItemsState extends State<PopularShownItems> {

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
  // to save user interaction
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
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (c)=>  ItemPage(model: widget.model,)));
                          saveUserInteraction("Viewed");
                          logUserView();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child:Image.network(
                            widget.model!.thumbnailUrl!,
                            height: 120,
                            width: 165,
                          ),
                        ),
                      ),
                       Text(widget.model!.itemTitle!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                      const SizedBox(height: 3,),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            widget.model!.shortInfo!,
                            style: const TextStyle(
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text( "\$"+widget.model!.itemPrice!,
                            style: const TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight:  FontWeight.bold,
                          ),),
                          const Icon(Icons.favorite_border,
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
