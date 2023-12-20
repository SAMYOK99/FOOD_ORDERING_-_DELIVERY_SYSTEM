import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:my_tiffin/widgets/when_user_clicks_menu.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
 Future<QuerySnapshot>? itemNameList;
String itemNameText = "";

initItemSearch(String textEntered) {
  itemNameList = FirebaseFirestore.instance.collection("items").where("itemTitle",isGreaterThanOrEqualTo:textEntered)
      .get();

}

class _SearchScreenState extends State<SearchScreen> {
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
              hintText: 'What would you like to have?',
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
                return ClicksMenu(
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
