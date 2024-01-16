import 'package:clippy_flutter/arc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/staff_home_screen.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/update_item.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:my_tiffin/models/menu.dart';
import 'package:provider/provider.dart';

class StaffItemPage extends StatefulWidget {
  Items? model;


  StaffItemPage({Key? key, this.model}) : super(key: key);

  @override
  State<StaffItemPage> createState() => _StaffItemPageState();
}

class _StaffItemPageState extends State<StaffItemPage> {
  deleteItem(String itemUID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this item?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {
                Menu selectedMenu =
                Provider.of<Menu>(context, listen: false);
                String? selectedTab = selectedMenu.selectedTab;
                FirebaseFirestore.instance
                    .collection("menus")
                    .doc(selectedTab)
                    .collection("items")
                    .doc(itemUID)
                    .delete()
                    .then((value) {
                  FirebaseFirestore.instance
                      .collection("items")
                      .doc(itemUID)
                      .delete();
                  Fluttertoast.showToast(msg: "Item Deleted");
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (c) => const StaffHomeScreen()));
                });
                Navigator.of(context).pop(); // Close the dialog after deletion
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  itemBottomNavBar() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => ItemUpdateScreen(model: widget.model,)));
                },
                style: ButtonStyle(
                  backgroundColor:
                   MaterialStateProperty.all(Colors.green),
                  padding:  MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.change_circle,
                  color: Colors.white,
                ),
                label: const Text(
                  'Change',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  deleteItem(widget.model!.itemID);
                },
                style: ButtonStyle(
                  backgroundColor:
                   MaterialStateProperty.all(Colors.green),
                  padding:  MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                icon: const Icon(
                  CupertinoIcons.delete,
                  color: Colors.white,
                ),
                label: const Text(
                  'Delete',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.network(
                    widget.model!.thumbnailUrl!,
                    height: 300,
                  ),
                ),
                Arc(
                  edge: Edge.TOP,
                  arcType: ArcType.CONVEY,
                  height: 30,
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 60, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.model!.itemTitle!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "\$${widget.model!.itemPrice!}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              widget.model!.description!,
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
              ],
            ),
          ),
          itemBottomNavBar(),
        ],
      ),
    );
  }
}
