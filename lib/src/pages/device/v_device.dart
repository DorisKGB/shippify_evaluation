import 'package:flutter/material.dart';

class VDevice extends StatefulWidget {
   
  const VDevice({Key? key}) : super(key: key);

  @override
  State<VDevice> createState() => _VDeviceState();
}

class _VDeviceState extends State<VDevice> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
         child: Text('VSignUp'),
      ),
    );
  }
}