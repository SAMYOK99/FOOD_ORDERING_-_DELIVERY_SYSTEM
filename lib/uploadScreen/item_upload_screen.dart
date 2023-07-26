import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/staff_home_screen.dart';
import 'package:my_tiffin/widgets/progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart' as  storageRef;
import 'package:my_tiffin/widgets/staff_widget/staff_category_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/items.dart';
import '../models/menu.dart';
import '../riders_app/widgets/error_dialog.dart';
import '../widgets/dialog_loading.dart';

class ItemUploadScreen extends StatefulWidget {
  final Items? model;
  // final ValueChanged<bool> onButtonClicked;

  ItemUploadScreen({this.model});

  @override
  _ItemUploadScreenState createState() => _ItemUploadScreenState();
}

class _ItemUploadScreenState extends State<ItemUploadScreen> {

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  bool uploading = false;
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

// these are called methods if they are outside the class they are called functions
  void initState() {
    super.initState();
    // Access the selectedTab in initState using the Consumer widget
    Menu selectedMenu = Provider.of<Menu>(context, listen: false);
    String? selectedTab = selectedMenu.selectedTab;
    print('Selected Tab in initState: $selectedTab');
  }
  defaultScreen(){
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.green
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (c)=> StaffHomeScreen()));

          },

        ),


        centerTitle: true,
        title: const Text("Add New Menu"),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,

        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
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
                'Add New Item',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,

                ),
              ),
              onPressed: (){
                 takeImage(context);
                // widget.onButtonClicked(true);
              }
          ),
        ),
      ),

    );
  }

  takeImage(mContext)
  {
    return showDialog(
      context: mContext,
      builder: (context)
      {
        return SimpleDialog(
          title: const Text("Item Image", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          children: [
            SimpleDialogOption(
              onPressed: captureImageWithCamera,
              child: const Text(
                "Capture with Camera",
                style: TextStyle(color: Colors.green),
              ),
            ),
            SimpleDialogOption(
              onPressed: pickImageFromGallery,
              child: const Text(
                "Select from Gallery",
                style: TextStyle(color: Colors.green),
              ),
            ),
            SimpleDialogOption(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: ()=> Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  captureImageWithCamera() async
  {
    Navigator.pop(context);

    imageXFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720 ,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }

  pickImageFromGallery() async
  {
    Navigator.pop(context);

    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720 ,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }
  pickFromGallery() async{
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1200,
    );
    setState(() {
      imageXFile;
    });
  }

  itemFormScreen(){
  return Scaffold(
    appBar: AppBar(
      iconTheme: const IconThemeData(
          color: Colors.green
      ),
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.green,),
        onPressed: () {
          clearMenuUploadForm();
        },

      ),

      centerTitle: true,
      title: const Text("Adding New Item"),
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
    body: ListView(
      children: [
        uploading == true ? linearProgress() : const Text(""),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 250,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(imageXFile!.path),
                        // width: double.infinity,
                        // width: 100,
                      ),
                      fit: BoxFit.cover,

                    ),
                  ),
                ),
              ),
            ),
        ),
        ListTile(
          leading: const Icon(Icons.perm_device_information, color: Colors.green,),
          title: Container(
            width: 300,
            child: TextField(
              style: const TextStyle(
                color: Colors.black,
              ),
              controller: shortInfoController,
              decoration: const InputDecoration(
                hintText: "Item Info",
                hintStyle: TextStyle(color: Colors.grey,),
                border: InputBorder.none
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
        ),
        ListTile(
          leading: const Icon(Icons.title, color: Colors.green,),
          title: Container(
            width: 300,
            child: TextField(
              style: const TextStyle(
                color: Colors.black,
              ),
              controller: titleController,
              decoration: const InputDecoration(
                  hintText: "Item Title",
                  hintStyle: TextStyle(color: Colors.grey,),
                  border: InputBorder.none
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
        ),
        ListTile(
          leading: const Icon(Icons.description, color: Colors.green,),
          title: Container(
            width: 300,
            child: TextField(
              style: const TextStyle(
                color: Colors.black,
              ),
              controller: descriptionController,
              decoration: const InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: Colors.grey,),
                  border: InputBorder.none
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
        ),
        ListTile(
          leading: const Icon(Icons.monetization_on, color: Colors.green,),
          title: Container(
            width: 300,
            child: TextField(
              style: const TextStyle(
                color: Colors.black,
              ),
              controller: priceController,
              decoration: const InputDecoration(
                  hintText: "Item Price",
                  hintStyle: TextStyle(color: Colors.grey,),
                  border: InputBorder.none
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.black,
        ),



      ],
    ),
  );
  }
  clearMenuUploadForm(){
  setState(() {
    shortInfoController.clear();
    titleController.clear();
    priceController.clear();
    descriptionController.clear();
    imageXFile=null;
  });
  }

  validateUploadForm() async {

  if(imageXFile!=null){
    if( shortInfoController.text.isNotEmpty && titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && priceController.text.isNotEmpty){
      if(isNumeric(priceController.text)){
        showDialog(
            context: context,
            builder: (c) {
              return const DialogLoading(
                message: 'Adding New Item',
              );
            }
        );
        setState(() {
          uploading = true;
        });
        // uploading image
        String downloadUrl = await uploadImage(File(imageXFile!.path));
        // save info to firestore
        saveInfo(downloadUrl);// parameters are going to stored in firestore
      }

      else{
        showDialog(
            context: context,
            builder: (c) {
              return const ErrorDialog(
                message: 'Price must be numeric value',
              );
            }
        );
      }

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
  else{
    showDialog(
        context: context,
        builder: (c) {
          return const ErrorDialog(
            message: 'Please pick an menu image',
          );
        }
    );
  }
  }

//for number validation
  bool isNumeric(String value) {

    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(value);
  }
  saveInfo(String downloadUrl){
    Menu selectedMenu = Provider.of<Menu>(context, listen: false);
    String? selectedTab = selectedMenu.selectedTab;
    final ref = FirebaseFirestore.instance
        .collection("menus")
        .doc(selectedTab)
        .collection("items");

    ref.doc(uniqueIdName).set({
      "itemID" : uniqueIdName,
      "menuId": selectedTab,
      "staffUID": sharedPreferences!.getString("uid"),
      "staffName":sharedPreferences!.getString("name"),
      "shortInfo": shortInfoController.text.toString(),
      "itemTitle": titleController.text.toString(),
      "description":descriptionController.text.toString(),
      "itemPrice":priceController.text.toString(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,

    }).then((value) {
      final itemRef = FirebaseFirestore.instance
          .collection("items");
      itemRef.doc(uniqueIdName).set({
        "itemID" : uniqueIdName,
        "menuId": selectedTab,
        "staffUID": sharedPreferences!.getString("uid"),
        "staffName":sharedPreferences!.getString("name"),
        "shortInfo": shortInfoController.text.toString(),
        "itemTitle": titleController.text.toString(),
        "description":descriptionController.text.toString(),
        "itemPrice":priceController.text.toString(),
        "publishedDate": DateTime.now(),
        "status": "available",
        "thumbnailUrl": downloadUrl,

      });

    }).then((value) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Item added successfully.'),
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
        uniqueIdName= DateTime.now().millisecondsSinceEpoch.toString();
        uploading= false;
      });
    });

  }
  uploadImage(mImageFile) async {
    storageRef.Reference reference = storageRef.FirebaseStorage.instance
        .ref()
        .child("items");
    storageRef.UploadTask uploadTask = reference.child(uniqueIdName+ ".jpg").putFile(mImageFile);
    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() =>
    {
    });

    Future<String> downloadURL = taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }



  @override
  Widget build(BuildContext context) {
    return imageXFile == null? defaultScreen(): itemFormScreen();


  }
}
