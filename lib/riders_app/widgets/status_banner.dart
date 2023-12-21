import 'package:flutter/material.dart';
import 'package:my_tiffin/riders_app/homeScreens/home_screen.dart';

class StatusBanner extends StatelessWidget {
  final bool status;
  final String orderStatus;

  const StatusBanner({
    Key? key,
    required this.status,
    required this.orderStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String message;
    IconData? iconData;

    status ? iconData = Icons.done : iconData = Icons.cancel;
    status ? message = "Successful" : message = "Unsuccessful";

    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (c) => const RiderHomeScreen()));
        },
        child: const Icon(
          Icons.arrow_back,
          size: 33,
          color: Colors.green,
        ),
      ),
      title: Text(
        orderStatus == "ended" ? "Package Delivered $message" : "Order Placed $message",
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      actions: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.green,
          child: Center(
            child: Icon(
              iconData,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
