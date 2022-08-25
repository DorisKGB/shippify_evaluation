import 'package:flutter/material.dart';

import '../../../utils/bloc_pattern/bloc_provider.dart';
import '../v_device.dart';
import 'b_device.dart';


class PDevice extends StatelessWidget {
  const PDevice({Key? key, required this.bloc}) : super(key: key);
  final BDevice Function() bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(child: const VDevice(), blocBuilder: () => bloc());
  }
}
