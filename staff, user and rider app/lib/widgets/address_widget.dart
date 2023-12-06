import 'package:flutter/material.dart';
import 'package:my_tiffin/asistantMethods/address_changer.dart';
import 'package:my_tiffin/homeScreens/place_order_screen.dart';
import 'package:my_tiffin/maps/maps.dart';
import 'package:my_tiffin/models/address.dart';
import 'package:provider/provider.dart';

class AddressWidget extends StatefulWidget {
  final Address? model;
  final int currentIndex;
  final int value;
  final String? addressId;
  final double? totalAmount;



  AddressWidget({super.key,
     required this.model,
     required this.currentIndex,
     required this.totalAmount,
     required this.addressId,
     required this.value
   });




  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<AddressWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
// select this address
        Provider.of<AddressChanger>(context,listen: false).displayResult(widget.value);// default if there is only one address that one is selected


      },
      child: Card(
        color: const Color(0x00c7f6b6).withOpacity(0.4),
        child: Column(
          children: [
            // Address info
            Row(
               children: [
                 Radio(
                   value: widget.value,
                  groupValue: widget.currentIndex,
                  onChanged: (val){
                // provider
                    Provider.of<AddressChanger>(context,listen: false).displayResult(val);

                  }),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(
                       padding: const EdgeInsets.all(10),
                       width: MediaQuery.of(context).size.width*0.8,
                       child: Table(
                         children: [
                           TableRow(
                             children: [
                               const Text("Name:",
                               style: TextStyle(
                                 color: Colors.black,
                                 fontWeight: FontWeight.bold,
                               ),),
                               Text(widget.model!.name.toString()),
                             ],
                           ),
                           TableRow(
                             children: [
                               const Text("Phone Number:",
                               style: TextStyle(
                                 color: Colors.black,
                                 fontWeight: FontWeight.bold,
                               ),),
                               Text(widget.model!.phoneNumber.toString()),
                             ],
                           ),
                           TableRow(
                             children: [
                               const Text("Chowk:",
                                 style: TextStyle(
                                   color: Colors.black,
                                   fontWeight: FontWeight.bold,
                                 ),),
                               Text(widget.model!.chowk.toString()),
                             ],
                           ),
                           TableRow(
                             children: [
                               const Text("City:",
                                 style: TextStyle(
                                   color: Colors.black,
                                   fontWeight: FontWeight.bold,
                                 ),),
                               Text(widget.model!.city.toString()),
                             ],
                           ),
                           TableRow(
                             children: [
                               const Text("Province:",
                                 style: TextStyle(
                                   color: Colors.black,
                                   fontWeight: FontWeight.bold,
                                 ),),
                               Text(widget.model!.state.toString()),
                             ],
                           ),
                           TableRow(
                             children: [
                               const Text("Country:",
                                 style: TextStyle(
                                   color: Colors.black,
                                   fontWeight: FontWeight.bold,
                                 ),),
                               Text(widget.model!.country.toString()),
                             ],
                           ),
                           TableRow(
                             children: [
                               const Text("Full Address:",
                                 style: TextStyle(
                                   color: Colors.black,
                                   fontWeight: FontWeight.bold,
                                 ),),
                               Text(widget.model!.fullAddress.toString()),
                             ],
                           ),

                         ],
                       ),
                     )
                   ],
                 )
               ],
            ),
            //button to check on maps
            ElevatedButton(
              onPressed: (){
                MapsUtils.openMapWithPosition(widget.model!.lat!, widget.model!.lng!);
                // MapsUtils.openMapWithAddress(widget.model!.fullAddress!);

            },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
              ),
                child: const Text("Check on Maps"),
            ),
            //button to proceed
            widget.value == Provider.of<AddressChanger>(context).count?
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=> PlaceOrderScreen(
                          addressID: widget.addressId,
                          totalAmount: widget.totalAmount!.toDouble())));
                    },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                    child: const Text("Proceed",
                    style: TextStyle(
                      color: Colors.white,
                    ),),)
                : Container(),


          ],
        ),



      ),
    );
  }
}
