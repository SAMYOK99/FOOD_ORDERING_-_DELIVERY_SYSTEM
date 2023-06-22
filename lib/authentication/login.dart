import 'package:flutter/material.dart';

import '../widgets/custom_text_field.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}




class _LoginScreenState extends State<LoginScreen> {
  bool isRememberMe= false;
  Widget forgotPassBtn(){
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () => print('Forgot password'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: const EdgeInsets.only(right:0),
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
  Widget rememberMe(){
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
                onChanged:(value){
                  setState(() {
                    isRememberMe = value!;

                  });
                },

    ),
          ),
          const Text('Remember me',
            style: TextStyle(
               color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );

  }

  final GlobalKey<FormState> _formkey=  GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 120 ,
      ),
      child: Column(
        children: [
          Form(
            key: _formkey,
            child: Column(
              children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      const Text('Email',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),),
                      const SizedBox(height: 10,),
                      CustomTextField(
                        data: Icons.email,
                        controller: emailcontroller,
                        hintText: 'Email',
                        isObsecre: false,
                      ),

                      const SizedBox(height: 20,),

                      const Text('Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),),
                      const SizedBox(height: 10,),
                      CustomTextField(
                        data: Icons.lock,
                        controller: passwordcontroller,
                        hintText: 'Password',
                        isObsecre: true,
                      ),

                      ],
                  ),),

              ],


            ),
          ),

          forgotPassBtn(),
          rememberMe(),

          Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                'LOGIN',
                style: TextStyle(
                  color: Color(0xff5ac18e),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,

                ),
              ),
              onPressed: ()=>print('button clicked'),
            ),
          ),
        ],
      ),

    );
  }
}
