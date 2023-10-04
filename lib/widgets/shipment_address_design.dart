import 'package:flutter/material.dart';
import 'package:my_tiffin/homeScreens/home_screen.dart';
import 'package:my_tiffin/models/address.dart';
import 'package:my_tiffin/splashScreen/splash_screen.dart';
class ShipmentAddressDesign extends StatelessWidget {
  final Address? model;

  const ShipmentAddressDesign({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const Padding(
          padding:  EdgeInsets.all(10.0),
          child:  Text("Shipping Details:",style: TextStyle(
            color: Colors.black,fontWeight: FontWeight.bold,
          ),),
        ),
        const SizedBox(height: 10.0,),
         Container(
           padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
             width: MediaQuery.of(context).size.width,
           child: Table(
             children: [
               TableRow(
                 children: [
                  const Text("Name",style: TextStyle(color: Colors.black),) ,
                   Text(model!.name!),
                 ]
               ),
               TableRow(
                 children: [
                  const Text("Phone Number",style: TextStyle(color: Colors.black),) ,
                   Text(model!.phoneNumber!),
                 ]
               ),
             ],
           ),
         ),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(model!.fullAddress!,textAlign: TextAlign.justify ,),
        ),
        const SizedBox(height: 60,),

        Center(
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 40,
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (c)=>const MySplashScreen()));
              },
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.green),
                padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15,horizontal: 20,),),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),)),
              ),
              child: const Text('Go Back', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,),),
            ),
          ),
        )
      ],

    );
  }
}
