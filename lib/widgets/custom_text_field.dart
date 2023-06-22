import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;// for hint text
  bool isObsecre = true;// to secure password
  bool? enabled = true;// enable user to write in the textfield

CustomTextField({super.key,
this.controller,
this.data,
this.hintText,
required this.isObsecre,
this.enabled,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
          color: Colors.black26,
          blurRadius: 4 ,
          offset: Offset(0,2)
        )
        ]

      ),
      height: 60 ,
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        obscureText: isObsecre,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
         border: InputBorder.none,
         prefixIcon: Icon(
           data,
           color: Color(0xff5ac18e),
         ),
            focusColor: Theme.of(context).primaryColor,
           hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
