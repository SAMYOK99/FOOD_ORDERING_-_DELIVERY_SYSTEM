import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../asistantMethods/totalAmount.dart';
class CartBottomNavBar extends StatelessWidget {
  const CartBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Row(
          children:[
            const Text("Total: ",style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),),
             const SizedBox(
               width: 15,
             ),
            Consumer<TotalAmount>(builder: (context,amountProvider,c){
              return Text("\$ ${amountProvider.totalamt}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,

                ),
              );

            }),
          ],
        ),
     ElevatedButton(
        onPressed: (){
         // 1. Check the item is already in cart or not
          // 2. Add to cart
        },
     style: ButtonStyle(
     backgroundColor: const MaterialStatePropertyAll(Colors.green),
       padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15,horizontal: 20,),),
       shape: MaterialStatePropertyAll(RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(20),)),
   ),
    child: const Text('Order Now', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,),),
    )],
      ),
    ),);
  }
}
