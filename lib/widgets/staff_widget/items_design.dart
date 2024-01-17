
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_tiffin/homeScreens/staff_main_screens/staff_item_page.dart';
import 'package:my_tiffin/models/items.dart';

class ItemsDesign extends StatefulWidget {
  Items? model;
  BuildContext? context;

  ItemsDesign({this.model, this.context});

  @override
  State<ItemsDesign> createState() => _ItemsDesignState();
}

class _ItemsDesignState extends State<ItemsDesign> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(0,10,0,5),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        height: MediaQuery.of(context).size.height*0.18,
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
                          builder: (c) => StaffItemPage(model: widget.model,)));
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      alignment: Alignment.bottomCenter,
                      child: Image.network(
                        widget.model!.thumbnailUrl!,
                        height: 120,
                        width: 150,
                      ),
                    ),
                  ),
                  Container(
                    width: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.model!.itemTitle!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        Text(
                          widget.model!.shortInfo!,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),),
                        const SizedBox( height: 20,),
                        Text(
                          "\$"+widget.model!.itemPrice!,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),),

                      ],
                    ),
                  ),

                ],
              ),

            ]
        ),
      ),
    );

  }
}
