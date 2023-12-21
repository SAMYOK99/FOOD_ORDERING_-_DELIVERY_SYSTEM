import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:my_tiffin/uploadScreen/item_upload_screen.dart';
import 'package:my_tiffin/widgets/progress_bar.dart';
import 'package:my_tiffin/widgets/staff_widget/items_design.dart';
import 'package:provider/provider.dart';
import '../../models/menu.dart';

class CategoryItemWidget extends StatefulWidget {
  final Items? model;
  CategoryItemWidget({this.model});
  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  deleteMenu(){
    Menu selectedMenu = Provider.of<Menu>(context, listen: false);
    String? selectedTab = selectedMenu.selectedTab;
    FirebaseFirestore.instance
        .collection("menus")
        .doc(selectedTab)
        .delete();
    Fluttertoast.showToast(msg: "Item Deleted");

  }

  @override
  Widget build(BuildContext context) {
    String? selectedTab = Provider.of<Menu>(context).selectedTab;
    print('Selected Tab: $selectedTab');
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 15, 10),
        width: double.infinity,
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('menus')
                    .doc(selectedTab)
                    .collection('items')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: circularProgress());
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No items available.',style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                    )));
                  } else {
                    return Container(
                      width: 350,
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: ListView(
                        shrinkWrap: true,
                        children: List.generate(snapshot.data!.docs.length, (index) {
                          Items model = Items.fromJson(
                            snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                          );
                          return ItemsDesign(
                            model: model,
                            context: context,
                          );
                        }),
                      ),
                    );
                  }
                },
              ),


            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (c) => ItemUploadScreen(model: widget.model,)),
                      );
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Confirm Delete"),
                            content: const Text("Are you sure you want to delete this Menu?"),
                            actions: [
                              TextButton(
                                child: const Text("Cancel",
                                    style: TextStyle(
                                      color: Colors.green,
                                    )),
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                },
                              ),
                              TextButton(
                                child: const Text("Delete",
                                style: TextStyle(
                                  color: Colors.red,
                                ),),
                                onPressed: () {
                                  Navigator.pop(context); // Close the dialog
                                  deleteMenu();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      },
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
