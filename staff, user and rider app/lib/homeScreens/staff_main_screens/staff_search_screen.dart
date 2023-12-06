import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/staff_item_page.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:my_tiffin/widgets/staff_widget/items_design.dart';
import 'package:my_tiffin/widgets/when_user_clicks_menu.dart';

class StaffSearchScreen extends StatefulWidget {
  const StaffSearchScreen({super.key});

  @override
  State<StaffSearchScreen> createState() => _StaffSearchScreenState();
}
Future<QuerySnapshot>? itemNameList;
String itemNameText = "";

initItemSearch(String textEntered) {
  itemNameList = FirebaseFirestore.instance.collection("items").where("itemTitle",isGreaterThanOrEqualTo:textEntered)
      .get();

}

class _StaffSearchScreenState extends State<StaffSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          size: 33,
          color: Colors.green,
        ),
        title:
        TextFormField(
          onChanged: (textEntered){
            setState(() {
              itemNameText = textEntered;// to access the entered item outside the onChanged(){}
            });
            // init
            initItemSearch(textEntered);
          },
          decoration: InputDecoration(
            hintText: 'Search Item',
            hintStyle: const TextStyle(
              fontSize: 18,
            ),
            border: InputBorder.none,
            suffixIcon:  IconButton(onPressed: (){
              initItemSearch(itemNameText);
            },
              icon: const Icon(Icons.search,
                color: Colors.green,
                size: 33,)
              ,),

          ),

        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: itemNameList,
        builder: (context,snapshot){
          return  snapshot.hasData? Container(
            width: 350,
            height: MediaQuery.of(context).size.height * 1, // Adjust the height as needed
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
          ): const Center(child: Text("No Item Found"),);
        },
      ),

    );

  }
}