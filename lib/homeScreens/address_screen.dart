import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/asistantMethods/address_changer.dart';
import 'package:my_tiffin/homeScreens/save_address_screen.dart';
import 'package:my_tiffin/models/address.dart';
import 'package:my_tiffin/riders_app/widgets/progress_bar.dart';
import 'package:my_tiffin/widgets/address_widget.dart';
import 'package:provider/provider.dart';

import '../globalVariables/globleVariable.dart';

class AddressScreen extends StatefulWidget {
  double totalAmount;
   AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  addNewNavigationBar(){
    return Container(
      color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (c)=>SavedAddressScreen()));
              },
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.green),
                padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15,horizontal: 20,),),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),)),
              ),
              child: const Text('Add New Address', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,color: Colors.white),),
            )],
        ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            size: 33,
            color: Colors.green
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  alignment: Alignment.centerLeft,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Select Address:",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Consumer<AddressChanger>(builder: (context,address,c){
                  return Container(
                    width: 385,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("users")
                      .doc(sharedPreferences!.getString("uid"))
                      .collection("userAddress").snapshots(),
                        builder: (context, snapshot)
                        {
                          if (snapshot == null || !snapshot.hasData) {
                            return Center(
                              child: circularProgress(),
                            );
                          } else if (snapshot.data!.docs.length == 0) {
                            return Container();
                          } else {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return AddressWidget(
                                    model: Address.fromJson(
                                      snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                                    ),
                                    currentIndex: address.count,
                                    totalAmount: widget.totalAmount,
                                    addressId: snapshot.data!.docs[index].id,
                                    value: index,
                                  );
                                },
                              ),
                            );
                          }



                        },
                      ),

                  );

                }),
              ],
            ),
    ),


        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: addNewNavigationBar(),
      )
    );
  }
}
