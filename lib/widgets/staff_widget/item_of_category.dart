import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/staff_item_page.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:my_tiffin/widgets/progress_bar.dart';
import 'package:provider/provider.dart';
import '../../models/menu.dart';
import '../../uploadScreen/item_upload_screen.dart';

class CategoryItemWidget extends StatefulWidget {
  final Items? model;
  // final ValueChanged<bool> onButtonClicked;

  CategoryItemWidget({this.model});

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  bool isButtonClicked= false;

  void initState() {
    super.initState();
    // Access the selectedTab in initState using the Consumer widget
    Menu selectedMenu = Provider.of<Menu>(context, listen: false);
    String? selectedTab = selectedMenu.selectedTab;
    print('Selected Tab in initState: $selectedTab');
  }
  viewItems(
  {required Items model, required BuildContext? context }){
    Padding(padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: MediaQuery.of(context!).size.width * 0.9,
        height: MediaQuery.of(context!).size.height* 0.2,
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
        child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>const StaffItemPage()));
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child:   Image.network(
                        widget.model!.thumbnailUrl!,
                        height: 120,
                        width: 150,
                      ),
                      // Image.asset(
                      //   "images/burger.png",
                      //   height: 120,
                      //   width: 150,
                      // ),
                    ),
                  ),
                  Container(
                    width: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                         Text(
                          widget.model!.itemTitle!,
                          style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),),
                         Text(
                           widget.model!.shortInfo!,
                           style: TextStyle(
                           fontSize: 16,
                           fontWeight: FontWeight.bold,
                        ),),
                        RatingBar.builder(
                          initialRating: 4,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 18,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                          itemBuilder: (context,_)=>const Icon(
                            Icons.star,
                            color: Colors.green,

                          ),
                          onRatingUpdate: (index){},),
                          Text(
                          widget.model!.itemPrice!,
                          style: TextStyle(
                          fontSize: 17,
                          color: Colors.green,
                          fontWeight:  FontWeight.bold,
                        ),),
                      ],
                    ),
                  ),

                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.favorite_border,
                      color: Colors.green,
                      size: 26,
                    ),
                    Icon(
                      CupertinoIcons.cart,
                      color: Colors.green,
                      size: 26,
                    ),
                  ],
                ),
              ),
            ]
        ),
      ),
    );

  }

  @override
  void handleButtonClicked(bool isClicked) {
    if (isClicked) {
      // Button inside MenuUploadScreen is clicked
      setState(() {
        isButtonClicked = isClicked;
      });
    }
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 15, 40),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<Menu>(builder: (context, selectedMenu, _) {
                   String? selectedTab = selectedMenu.selectedTab;
                   return StreamBuilder<QuerySnapshot>(
                       stream :
                       FirebaseFirestore.instance.collection('menus').doc(selectedTab).collection('items').snapshots(),

                       builder: (context,snapshot){
                         return !snapshot.hasData ? Center(child: circularProgress()):
                         ListView.builder(
                           itemBuilder: (context, index) {
                             Items model = Items.fromJson(
                               snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                             );
                             return viewItems(
                               model: model,
                               context: context,
                             );
                             },
                           itemCount: snapshot.data!.docs.length,
                         );
                       });
                  }
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor:Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      child: const Text(
                        'Add Item',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,

                        ),
                      ),
                      onPressed: ()=>{
                        Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemUploadScreen())),
                        // widget.onButtonClicked(true),

                      }
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor:Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal:40,vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,

                        ),
                      ),
                      onPressed: ()=>{

                      }
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50,),
          ],
        ),

      ),
    );
  }
}