import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  String? hint;
  final TextEditingController? controller;
  TextFieldWidget({super.key, this.hint, this.controller});
  
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8),
    child: TextFormField(
      controller: controller,
        decoration:  InputDecoration.collapsed(hintText: hint),
      validator: (value)=>value!.isEmpty?"Field must not be Empty":null,
    ),
    );
  }
}
