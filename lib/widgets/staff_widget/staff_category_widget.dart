import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/homeScreens/item_page.dart';
import 'package:my_tiffin/uploadScreen/menu_upload_screen.dart';
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
              fontSize: 20,
            ),
            indicatorColor: Colors.transparent,
            isScrollable: true,
            controller: _tabController,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            labelPadding: const EdgeInsets.fromLTRB(5,2,25,2),


            tabs:  [
              Tab(text: "Burger",),
              Tab(text: "loladfadfad",),
              Tab(text: "lodfdfadfadl",),
              Tab(text: "lodfadfadfadfal",),
              Tab(text: "lol",),
              Tab(text: "lol",),
              Tab(icon: Icon(Icons.add, size: 40,),),


            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            controller: _tabController,
            children: [
              const CategoryItemWidget(),
              const CategoryItemWidget(),
              const CategoryItemWidget(),
              const CategoryItemWidget(),
              const CategoryItemWidget(),
              const CategoryItemWidget(),
              const MenuUploadScreen(),





            ],
          ),
        ),
          ),
    );

  }
}
