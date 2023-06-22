
import 'package:my_tiffin/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../widgets/error_dialog.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formkey=  GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpassordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  XFile? imageXFile;

  Position? position;
  LocationPermission? permission;
  List<Placemark>? placeMarks;

  final ImagePicker _picker = ImagePicker();
  Future<void> _getImage() async{
    imageXFile= await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  getCurrentLocation() async {

    permission = await Geolocator.requestPermission();
    Position newPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    position= newPosition;
    placeMarks = await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude
      );
    Placemark pMark = placeMarks![0];// return from 0 th index

    String completeAddress = '${pMark.subThoroughfare},${pMark.thoroughfare}${pMark.subLocality},${pMark.locality},${pMark.subAdministrativeArea},${pMark.administrativeArea},${pMark.postalCode},${pMark.country}';
   locationcontroller.text= completeAddress;
  }

  Future<void> formValidation() async{
    if(imageXFile==null){
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: 'Please select an image',
            );
          }
        );
    }
    else
    {
      if(passwordcontroller.text==confirmpassordcontroller.text)
        {
          if(confirmpassordcontroller.text.isNotEmpty && namecontroller.text.isNotEmpty && emailcontroller.text.isNotEmpty && phonecontroller.text.isNotEmpty && locationcontroller.text.isNotEmpty  ){
            // start uploading data at first image

          }else{
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
      else
        {
          showDialog(
              context: context,
              builder: (c) {
                return const ErrorDialog(
                  message: 'Please Enter same password',
                );
              }
          );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children:  [
          const SizedBox(height:10,),
          InkWell(
            onTap: (){
              _getImage();
            },
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.20,
              backgroundColor: Colors.white,
              backgroundImage: imageXFile==null?null: FileImage(File(imageXFile!.path)) ,
              child: imageXFile==null
                ?
                Icon(
                  Icons.add_photo_alternate,
                  size: MediaQuery.of(context).size.width * 0.20,
                  color: Colors.grey,
                ):null,

            ),
          ),
          Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(margin: const EdgeInsets.fromLTRB(15,10,15,10),
                    child: CustomTextField(
                      data: Icons.person,
                      controller: namecontroller,
                      hintText: 'Name',
                      isObsecre: false,
                    ),),
                  Container(margin: const EdgeInsets.fromLTRB(15,10,15,10),
                    child: CustomTextField(
                    data: Icons.email,
                    controller: emailcontroller,
                    hintText: 'Email',
                    isObsecre: false,
                  ),),
                 Container(margin: const EdgeInsets.fromLTRB(15,10,15,10),
                   child: CustomTextField(
                    data: Icons.lock,
                    controller: passwordcontroller,
                    hintText: 'Password',
                    isObsecre: true,
                  ),),
                Container(margin: const EdgeInsets.fromLTRB(15,10,15,10),
                  child: CustomTextField(
                    data: Icons.lock,
                    controller: confirmpassordcontroller,
                    hintText: 'Confirm password',
                    isObsecre: true,
                  ),),
                Container(margin: const EdgeInsets.fromLTRB(15,10,15,10),
                   child: CustomTextField(
                    data: Icons.phone,
                    controller: phonecontroller,
                    hintText: 'Phone',
                    isObsecre: false,
                  ),),
                Container(margin: const EdgeInsets.fromLTRB(15,10,15,10),
                  child: CustomTextField(
                    data: Icons.my_location,
                    controller: locationcontroller,
                    hintText: 'Location',
                    isObsecre: false,
                    enabled: true,
                  ),),
                  Container(
                      width: 400,
                      height: 40,
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(

                        onPressed: () {
                          getCurrentLocation();
                        },
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                          label: const Text('Get my location',
                            style: TextStyle(
                            color: Colors.white,
                          ),
                          ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                      ),
                      )
                      ,),

                ],
              )
          ),
          const SizedBox(height: 30,),
          Container(
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
                'SIGN UP',
                style: TextStyle(
                  color: Color(0xff5ac18e),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,

                ),
              ),
              onPressed: ()=>{
                formValidation(),
              }
            ),
          ),

          const SizedBox(height: 30,),
        ],
      ),
    ) ;



  }
}
