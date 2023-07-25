import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/uploadScreen/item_upload_screen.dart';
import 'package:my_tiffin/uploadScreen/menu_upload_screen.dart';
import 'package:my_tiffin/widgets/progress_bar.dart';
import 'package:my_tiffin/widgets/staff_widget/item_of_category.dart';
import 'package:provider/provider.dart';


import '../../models/menu.dart';

class StaffCategoryItem extends StatefulWidget {
  const StaffCategoryItem({super.key});

  @override
  State<StaffCategoryItem> createState() => _StaffCategoryItemState();
}

class _StaffCategoryItemState extends State<StaffCategoryItem> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Tab> _tabs = [];
  List<Menu> _menus = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
     _tabController.addListener(_handleTabChange);
    _fetchTabsFromFirebase();

  }

  void _handleTabChange() {
    if (_tabController.index < _menus.length) {
      Menu selectedMenu = _menus[_tabController.index];
      selectedMenu.updateSelectedTab(selectedMenu.menuId!);
      print("Selected Menu ID: ${selectedMenu.menuId}, Menu Title: ${selectedMenu.menuTitle}");
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  void _fetchTabsFromFirebase() async {
    Stream<QuerySnapshot> stream =
    FirebaseFirestore.instance.collection('menus').snapshots();

    stream.listen((QuerySnapshot snapshot) {
      setState(() {
        _menus = snapshot.docs
            .map((doc) => Menu.fromJson(doc.data()! as Map<String, dynamic>))
            .toList();
        _menus.add(Menu(menuId:"1111", menuTitle: 'Add')); // Add the external permanent tab
        _tabs.clear();
        _tabs = _menus.map((menu) => Tab(text: menu.menuTitle!)).toList();
        _tabController = TabController(length: _tabs.length, vsync: this);
        _handleTabChange();
        for (var menu in _menus) {
          print('Menu Title: ${menu.menuTitle}');
        }

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return  _tabs.isEmpty? linearProgress():
    ChangeNotifierProvider<Menu>.value(
      value: _menus[_tabController.index],
      child: Container(
        width: 100,
        // width: MediaQuery.of(context).size.width * 0.1,
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
              physics: const NeverScrollableScrollPhysics(),
              labelPadding: const EdgeInsets.fromLTRB(5, 2, 25, 2),
              tabs: _tabs,
              onTap: (index) {
                Menu selectedMenu = _menus[_tabController.index];
                selectedMenu.updateSelectedTab(selectedMenu.menuId!); // Update selectedTab with menuId

                print("Selected Menu ID: ${selectedMenu.menuId}, Menu Title: ${selectedMenu.menuTitle}");
                setState(() {
                  _tabController.index = index;
                });
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
        child: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
        // ItemUploadScreen(),
        ItemUploadScreen(),
          MenuUploadScreen(
            // onButtonClicked: handleButtonClicked,
          ),

        ],

        ),),
        ),
      ),
    );
  }
}
