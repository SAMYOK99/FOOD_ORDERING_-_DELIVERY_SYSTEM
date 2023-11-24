import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/authentication/auth_screen.dart';
import 'package:my_tiffin/homeScreens/home_screen.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/staff_home_screen.dart';
import 'package:my_tiffin/riders_app/authentication/auth_screen.dart';
import 'package:my_tiffin/widgets/dialog_loading.dart';
import 'package:my_tiffin/widgets/error_dialog.dart';

import '../globalVariables/globleVariable.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRememberMe = false;

  Widget forgotPassBtn() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () => print('Forgot password'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.only(right: 0),
        ),
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget riderBtn() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (c) => const RiderAuthScreen()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8), // You can adjust the border radius as needed
          ),
          padding: const EdgeInsets.all(16), // Adjust the padding as needed
          child: const Text(
            'Are you a Rider?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget rememberMe() {
    return Container(
      height: 20,
      child: Row(
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
          const Text(
            'Remember me',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  formValidation() {
    if (emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty) {
      // Login
      loginNow();
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorDialog(
              message: 'Please enter your Email/Password',
            );
          });
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (c) {
          return const DialogLoading(
            message: 'Authenticating...',
          );
        });

    User? currentUser;
    await firebaseAuth
        .signInWithEmailAndPassword(
      email: emailcontroller.text.trim(),
      password: passwordcontroller.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user!;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });
    if (currentUser != null) {
      readDataAndSetDataLocally(currentUser!);
    }
  }

  // to store data locally
  Future readDataAndSetDataLocally(User currentUser) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        await sharedPreferences!.setString('uid', currentUser.uid);
        await sharedPreferences!.setString('email', snapshot.data()!['staffEmail']);
        await sharedPreferences!.setString('name', snapshot.data()!['staffName']); // used to access single users
        await sharedPreferences!.setString('photoUrl', snapshot.data()!['staffAvatarUrl']);
        await sharedPreferences!.setString('role', snapshot.data()!['role']);
        List<String> userCartList = snapshot.data()!['userCart'].cast<String>();
        await sharedPreferences!.setStringList('userCart', userCartList);

        if (snapshot.data()!['role'] == 'user') {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
        } else if (snapshot.data()!['role'] == 'staff') {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (c) => const StaffHomeScreen()));
        }
      } else {
        firebaseAuth.signOut();
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c) => const AuthScreen()));
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: 'Record does not exist. Please sign up first',
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 120,
      ),
      child: Column(
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
                      const SizedBox(height: 20,),
                      const Text(
                        'Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10,),
                      CustomTextField(
                        data: Icons.lock,
                        controller: passwordcontroller,
                        hintText: 'Password',
                        isObsecre: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          forgotPassBtn(),
          rememberMe(),
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
                'LOGIN',
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
          riderBtn(),
        ],
      ),
    );
  }
}
