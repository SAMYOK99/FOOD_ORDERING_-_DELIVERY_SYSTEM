import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBottomNavBar extends StatelessWidget {
  const ItemBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children:[
                Text("Total: ",style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),),
                SizedBox(
                  width: 15,
                ),
                Text("\$10",style: TextStyle(
                  fontSize: 19,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
            ElevatedButton.icon(
              onPressed: (){},
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(Colors.green),
                padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 13,horizontal: 15,),),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
              ),
              icon: Icon(CupertinoIcons.cart),

              label: const Text('Add to Cart', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,),),
            )],
        ),
      ),);
  }
}
