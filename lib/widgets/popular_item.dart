import 'package:flutter/material.dart';
import 'package:my_tiffin/homeScreens/item_page.dart';
import 'package:my_tiffin/models/items.dart';
class PopularShownItems extends StatefulWidget {
  Items? model;
  BuildContext? context;

  PopularShownItems({this.model, this.context});
  @override
  State<PopularShownItems> createState() => _PopularShownItemsState();
}

class _PopularShownItemsState extends State<PopularShownItems> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
        child: Row(
          children: [
            //single item
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: 170,
                height: 225,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0,3),

                    )
                  ],
                ),
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (c)=> const ItemPage()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child:Image.network(
                            widget.model!.thumbnailUrl!,
                            height: 120,
                            width: 165,
                          ),
                        ),
                      ),
                       Text(widget.model!.itemTitle!,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),),
                      const SizedBox(height: 4,),
                       Text(widget.model!.shortInfo!,
                        style: TextStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),),
                      const SizedBox(height: 12,),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text( "\$"+widget.model!.itemPrice!,
                            style: TextStyle(
                            fontSize: 17,
                            color: Colors.green,
                            fontWeight:  FontWeight.bold,
                          ),),
                          Icon(Icons.favorite_border,
                            color: Colors.green,
                            size: 26,
                          ),
                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
