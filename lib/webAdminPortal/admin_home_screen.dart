import 'package:flutter/material.dart';
class WebAdminHomeScreen extends StatefulWidget {
  const WebAdminHomeScreen({super.key});

  @override
  State<WebAdminHomeScreen> createState() => _WebAdminHomeScreenState();
}

class _WebAdminHomeScreenState extends State<WebAdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WEB ADMIN HOME SCREEN"),
      ),
      body: Text("WEB ADMIN BODY"),
    );
  }
}
