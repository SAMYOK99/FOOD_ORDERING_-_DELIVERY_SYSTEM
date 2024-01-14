import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_tiffin/authentication/auth_screen.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/widgets/custom_text_field.dart';
import 'package:my_tiffin/widgets/error_dialog.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  Future resetPassword() async{
    try{
      await firebaseAuth
          .sendPasswordResetEmail(
        email: emailcontroller.text.trim(),
      );
      Fluttertoast.showToast(
          msg: "Password reset link sent! Check you Email.");
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const AuthScreen()));


    } on FirebaseAuthException catch(e){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: e.message.toString(),
            );
          });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 33, color: Colors.green),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Form(
                 key: _formkey,
                 child: Column(
                   children: [
                     Container(
                       margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const Text('Enter you email And we will send you a paswword reset link.'),
                           const Text(
                             'Email',
                             style: TextStyle(
                                 color: Colors.white,
                                 fontSize: 16,
                                 fontWeight: FontWeight.bold),
                           ),
                           const SizedBox(height: 10,),
                           CustomTextField(
                             data: Icons.email,
                             controller: emailcontroller,
                             hintText: 'Email',
                             isObsecre: false,
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
               const SizedBox(height: 8,),
               Container(
                 margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                 width: double.infinity,
                 child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     elevation: 10,
                     backgroundColor: Colors.white,
                     padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10),
                     ),
                   ),
                   child: const Text(
                     'Reset Password',
                     style: TextStyle(
                       color: Colors.green,
                       fontWeight: FontWeight.bold,
                       fontSize: 18,
                     ),
                   ),
                   onPressed: () {
                     formValidation();
                   },
                 ),
               ),
             ],
           ),
        ),
      ),

    );
  }
  formValidation() {
    if (emailcontroller.text.isNotEmpty) {
      resetPassword();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: 'Please enter your Email.',
            );
          });
    }
  }

}
