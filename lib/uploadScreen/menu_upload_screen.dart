import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/staff_home_screen.dart';

class MenuUploadScreen extends StatefulWidget {
  const MenuUploadScreen({super.key});

  @override
  State<MenuUploadScreen> createState() => _MenuUploadScreenState();
}

class _MenuUploadScreenState extends State<MenuUploadScreen> {
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  defaultScreen(){
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.green
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c)=>const StaffHomeScreen()));
          },
        ),
        centerTitle: true,
        title: const Text("Add New Menu"),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,

        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
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
              "Add Menu",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18,

              ),
            ),
            onPressed: (){
              takeImage(context);
            }
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
          title: const Text("Menu Image", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          children: [
            SimpleDialogOption(
              child: const Text(
                "Capture with Camera",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: captureImageWithCamera,
            ),
            SimpleDialogOption(
              child: const Text(
                "Select from Gallery",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: pickImageFromGallery,
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
  @override
  Widget build(BuildContext context) {
    return defaultScreen  (
    );
  }
}
