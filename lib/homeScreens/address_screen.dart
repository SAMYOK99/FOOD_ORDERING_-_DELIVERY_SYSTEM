import 'package:flutter/material.dart';
import 'package:my_tiffin/homeScreens/save_address_screen.dart';

class AddressScreen extends StatefulWidget {
  double totalAmount;

   AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  addNewNavigationBar(){
    return Container(
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
              child: const Text('Add New Address', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,),),
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
                  child: const Text("Select Address:",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                const SizedBox(height: 20,),
              ],
            ),
    ),


        ],
      ),
      bottomNavigationBar: addNewNavigationBar(),
    );
  }
}
