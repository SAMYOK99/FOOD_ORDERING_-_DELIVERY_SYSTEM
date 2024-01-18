import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/homeScreens/item_page.dart';
import 'package:my_tiffin/models/items.dart';


class ClicksMenu extends StatefulWidget {
  Items? model;
  BuildContext? context;

  ClicksMenu({this.model, this.context});

  @override
  State<ClicksMenu> createState() => _ClicksMenuState();
}

class _ClicksMenuState extends State<ClicksMenu> {

  // deleteMenu(String itemUID){
  //   Menu selectedMenu = Provider.of<Menu>(context, listen: false);
  //   String? selectedTab = selectedMenu.selectedTab;
  //   FirebaseFirestore.instance
  //       .collection("menus")
  //       .doc(selectedTab)
  //       .collection("items")
  //       .doc(itemUID)
  //       .delete();
  //   Fluttertoast.showToast(msg: "Item Deleted");
  //
  // }

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
  // to store the user interaction
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
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        height: MediaQuery.of(context).size.height*0.22,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3),

            )
          ],
        ),
        child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (c) => ItemPage(model: widget.model,)));
                      saveUserInteraction("Viewed");
                      logUserView();

                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      alignment: Alignment.bottomCenter,
                      child: Image.network(
                        widget.model!.thumbnailUrl!,
                        height: 120,
                        width: 145,
                      ),
                      // Image.asset(
                      //   "images/burger.png",
                      //   height: 120,
                      //   width: 150,
                      // ),
                    ),
                  ),
                  Container(
                    width: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.model!.itemTitle!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        Text(
                          widget.model!.shortInfo!,
                          style: const TextStyle(
                            fontSize: 16,
                          ),),
                        // RatingBar.builder(
                        //   initialRating: 4,
                        //   minRating: 1,
                        //   direction: Axis.horizontal,
                        //   itemCount: 5,
                        //   itemSize: 18,
                        //   itemPadding: const EdgeInsets.symmetric(
                        //       horizontal: 4),
                        //   itemBuilder: (context, _) =>
                        //   const Icon(
                        //     Icons.star,
                        //     color: Colors.green,
                        //
                        //   ),
                        //   onRatingUpdate: (index) {},),
                        Text(
                          "\$"+widget.model!.itemPrice!,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
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


            ],

        ),
      ),

    );

  }
}
