
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../riders_app/widgets/error_dialog.dart';


class MenuUploadScreen extends StatefulWidget {

  final ValueChanged<bool> onButtonClicked;
  const MenuUploadScreen({Key? key, required this.onButtonClicked});

  @override
  _MenuUploadScreenState createState() => _MenuUploadScreenState();
}

class _MenuUploadScreenState extends State<MenuUploadScreen> {
  TextEditingController titleController = TextEditingController();
  bool uploading = false;
  late TabController _tabController;


// these are called methods if they are outside the class they are called functions

  void _handleTextFieldTap() {
    widget.onButtonClicked(true);
  }
  menuFormScreen(){
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.green
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Add New Menu"),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(onPressed: uploading ? null : ()=> validateUploadForm(),
            icon: const Icon(CupertinoIcons.check_mark,
              size: 35.0,
              color: Colors.green,
            ),


          )
        ],
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: ListView(
          children: [ListTile(
          leading: const Icon(Icons.title, color: Colors.green,),
          title: Container(
            width: 300,
            child: TextField(
              style: const TextStyle(
                color: Colors.black,
              ),
              controller: titleController,
              decoration: const InputDecoration(
                  hintText: "Menu Title",
                  hintStyle: TextStyle(color: Colors.grey,),
                  border: InputBorder.none
              ),
              onTap: _handleTextFieldTap,
            ),
          ),
            ),
            const Divider(
              color: Colors.black,
            ),


          ],
        ),
      ),
    );
  }
  clearMenuUploadForm(){
    setState(() {
      titleController.clear();
    });
  }

  validateUploadForm() async {
      if(titleController.text.isNotEmpty){
        setState(() {
          uploading = true;
        });
        // save info to firestore
        saveInfo(titleController.text);// parameters are going to stored in firestore
      }
      else{
        showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: 'All fields must be filled',
              );
            }
        );
      }


  }
  saveInfo(String titleMenu){
    FirebaseFirestore.instance
        .collection("menus").add({
      "menuTitle": titleController.text.toString(),
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Menu added successfully.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    clearMenuUploadForm();
    setState(() {
      uploading= false;
    });
  }




  @override
  Widget build(BuildContext context) {
    return menuFormScreen();
  }
}
