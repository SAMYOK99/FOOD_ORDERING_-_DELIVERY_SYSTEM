import 'package:flutter/material.dart';
import 'package:my_tiffin/models/menu.dart';
import 'package:my_tiffin/widgets/inside_category.dart';
class CategoryItem extends StatefulWidget {
  final Menu? model;
  BuildContext? context;
  CategoryItem({this.model,this.context});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5,),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: const EdgeInsets.all(8),
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
                ]
            ),
            child: InkWell(
              child: Text(widget.model!.menuTitle!,
                style: TextStyle(fontSize: 20,),
              ),
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder:(c)=> InsideCategory(model: widget.model,)));

              },
            ),

          ),
        ),
      );
  }
}
