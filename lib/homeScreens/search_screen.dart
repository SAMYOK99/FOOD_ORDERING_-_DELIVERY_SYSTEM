import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:my_tiffin/widgets/when_user_clicks_menu.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

Future<QuerySnapshot>? itemNameList;
String itemNameText = "";


initItemSearch(String textEntered) {
  itemNameList = FirebaseFirestore.instance
      .collection("items")
      .where("itemTitle", isGreaterThanOrEqualTo: textEntered)
      .get();
}

class _SearchScreenState extends State<SearchScreen> {
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  pickImageFromGallery() async {
    Navigator.pop(context as BuildContext);

    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }

  pickFromGallery() async {
    Navigator.pop(context as BuildContext);
    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1200,
    );
    setState(() {
      imageXFile;
    });
  }

  captureImageWithCamera() async {
    Navigator.pop(context as BuildContext);

    imageXFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }
  createLabeler() async {
    final modelPath = await getModelPath('assets/ml/1.tflite');
    final options = LocalLabelerOptions(
      // confidenceThreshold: confidenceThreshold,
      modelPath: modelPath,
    );
     imageLabeler = ImageLabeler(options: options);
  }


  Future<String> getModelPath(String asset) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$asset';
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }
  dynamic imageLabeler;
@override
void initState() {
    super.initState();
    createLabeler();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          size: 33,
          color: Colors.green,
        ),
        title: TextFormField(
          onChanged: (textEntered) {
            setState(() {
              itemNameText = textEntered;
            });
            initItemSearch(textEntered);
          },
          decoration: InputDecoration(
            hintText: 'What would you like to have?',
            hintStyle: const TextStyle(
              fontSize: 18,
            ),
            border: InputBorder.none,
            prefixIcon: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.green,
                size: 33,
              ),
              onPressed: () {
                initItemSearch(itemNameText);
              },
            ),

            suffixIcon: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return SimpleDialog(
                      title: const Text(
                        "Item Image",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.green,
                size: 33,
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: itemNameList,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Container(
            width: 350,
            height: MediaQuery.of(context).size.height *
                1,
            child: ListView(
              shrinkWrap: true,
              children: List.generate(snapshot.data!.docs.length,
                      (index) {
                    Items model = Items.fromJson(
                      snapshot.data!.docs[index].data()!
                      as Map<String, dynamic>,
                    );
                    return ClicksMenu(
                      model: model,
                      context: context,
                    );
                  }),
            ),
          )
              : const Center(child: Text("No Item Found"));
        },
      ),
    );
  }
}
