import 'package:flutter/material.dart';

import '../../uploadScreen/menu_upload_screen.dart';
import 'item_of_category.dart';
class StaffCategoryItem extends StatefulWidget {
  const StaffCategoryItem({super.key});

  @override
  State<StaffCategoryItem> createState() => _StaffCategoryItemState();
}

class _StaffCategoryItemState extends State<StaffCategoryItem>
    with TickerProviderStateMixin {
  bool isButtonClicked = false;
  late TabController _tabController;
  late IconData icon;
  int lastSelectedTab = 0;
  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabController.addListener(_handleTabChange);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(_handleTabChange);
  }
  void handleButtonClicked(bool isClicked) {
    if (isClicked) {
      // Button inside MenuUploadScreen is clicked
      setState(() {
        isButtonClicked = isClicked;
      });
    }
  }

  void _handleTabChange() {
    if (isButtonClicked && _tabController.indexIsChanging) {
      int lastIndex = _tabController.length - 1;
      int currentTab = _tabController.index;

      // Check if the user tries to switch from the last tab with the "add" icon to other tabs.
      if (lastSelectedTab == lastIndex && currentTab != lastIndex) {
        // Show the error dialog when trying to switch from the last tab to other tabs.
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Are you sure you want to exit? You will lose any unsaved progress.'),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isButtonClicked = true;
                    });
                    _tabController.animateTo(lastSelectedTab);
                    Navigator.of(context).pop();
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isButtonClicked = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Exit'),
                ),
              ],
            );
          },
        );
        // Prevent switching to other tabs from the last tab.
        _tabController.animateTo(lastSelectedTab);
      } else {
        // Allow switching to the last tab and remember the last selected tab index.
        lastSelectedTab = currentTab;
      }
    }

  }



  @override
  Widget build(BuildContext context) {
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
            labelPadding: const EdgeInsets.fromLTRB(5, 2, 25, 2),
            tabs: [
              Tab(text: "Burger"),
              Tab(text: "loladfadfad"),
              Tab(text: "lodfdfadfadl"),
              Tab(text: "lodfadfadfadfal"),
              Tab(text: "lol"),
              Tab(
                text: "lol",
              ),
              Tab(
                icon: Icon(Icons.add, size: 40),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            controller: _tabController,
            children: [
              CategoryItemWidget(),
              CategoryItemWidget(),
              CategoryItemWidget(),
              CategoryItemWidget(),
              CategoryItemWidget(),
              CategoryItemWidget(),
              MenuUploadScreen( onButtonClicked:  handleButtonClicked,),
            ],
          ),
        ),
      ),
    );
  }
}




