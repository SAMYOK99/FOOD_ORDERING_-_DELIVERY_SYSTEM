import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/items.dart';

class CartPageWidget extends StatefulWidget {
  final Items model;
  BuildContext context;
  final int? quantityNumber;

   CartPageWidget({
     required this.model,required this.context, required this.quantityNumber
});

  @override
  State<CartPageWidget> createState() => _CartPageWidgetState();
}


class _CartPageWidgetState extends State<CartPageWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.symmetric(vertical: 9),
            child: Container(
              width: 370,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: const Offset(0,3),

                  )
                ],
              ),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.network(
                      widget.model!.thumbnailUrl!,
                      height: 80,
                      width: 150,
                    ),
                  ),
                  Container(
                    width: 180,
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.model!.itemTitle!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        Text(widget.model!.shortInfo!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),),
                        Text("\$"+widget.model!.itemPrice!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),),
                      ],
                    ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.all((5)),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),

                      ) ,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(CupertinoIcons.minus,
                            color: Colors.white,

                          ),
                          Text(widget.quantityNumber.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,

                            ),
                          ),

                          Icon(CupertinoIcons.minus,
                            color: Colors.white,

                          ),
                        ],
                      ),
                    ),)


                ],
              ),
            ),
          ),

        ],
      ),

    );
  }
}
