import 'package:flutter/material.dart';
import 'package:my_tiffin/homeScreens/item_page.dart';
import 'package:my_tiffin/widgets/newest_item_widget.dart';
import 'package:my_tiffin/widgets/staff_widget/item_of_category.dart';

class StaffCategoryItem extends StatefulWidget {
  const StaffCategoryItem({super.key});

  @override
  State<StaffCategoryItem> createState() => _StaffCategoryItemState();
}

class _StaffCategoryItemState extends State<StaffCategoryItem> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 7, vsync: this);
    return Container(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
          elevation: 0,
          title: TabBar(
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            indicatorColor: Colors.green,
            isScrollable: true,
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            labelPadding: const EdgeInsets.fromLTRB(5,2,5,2),

            tabs: const [
              Tab(text: "lolasdfadfadf",),
              Tab(text: "loladfadfad",),
              Tab(text: "lodfdfadfadl",),
              Tab(text: "lodfadfadfadfal",),
              Tab(text: "lol",),
              Tab(text: "lol",),
              Tab(text: "lol",),

            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            controller: _tabController,
            children: [
              ListView(
                children: [
                  const CategoryItemWidget(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                    width: double.infinity,
                    child:  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,

                          backgroundColor:Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        child: const Text(
                          'DELETE',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,

                          ),
                        ),
                        onPressed: ()=>{
                        }
                    ),
                  ),


                ],
              ),
              ListView(
                children: [
                  const NewestItemWidget(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 0, 8, 20),
                    width: double.infinity,
                    child:  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 7,

                          backgroundColor:Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        child: const Text(
                          'DELETE',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,

                          ),
                        ),
                        onPressed: ()=>{
                        }
                    ),
                  ),


                ],
              ),
              ListView(
                children: [
                  const NewestItemWidget(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                    width: double.infinity,
                    child:  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,

                          backgroundColor:Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        child: const Text(
                          'DELETE',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,

                          ),
                        ),
                        onPressed: ()=>{
                        }
                    ),
                  ),


                ],
              ),
              ListView(
                children: [
                  const NewestItemWidget(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                    width: double.infinity,
                    child:  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,

                          backgroundColor:Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        child: const Text(
                          'DELETE',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,

                          ),
                        ),
                        onPressed: ()=>{
                        }
                    ),
                  ),


                ],
              ),
              ListView(
                children: [
                  const NewestItemWidget(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                    width: double.infinity,
                    child:  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,

                          backgroundColor:Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        child: const Text(
                          'DELETE',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,

                          ),
                        ),
                        onPressed: ()=>{
                        }
                    ),
                  ),


                ],
              ),
              ListView(
                children: [
                  const NewestItemWidget(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                    width: double.infinity,
                    child:  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,

                          backgroundColor:Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        child: const Text(
                          'DELETE',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,

                          ),
                        ),
                        onPressed: ()=>{
                        }
                    ),
                  ),


                ],
              ),
              ListView(
                children: [
                  const NewestItemWidget(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
                    width: double.infinity,
                    child:  ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,

                          backgroundColor:Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        child: const Text(
                          'DELETE',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,

                          ),
                        ),
                        onPressed: ()=>{
                        }
                    ),
                  ),


                ],
              ),


            ],
          ),
        ),
          ),
    );

  }
}
