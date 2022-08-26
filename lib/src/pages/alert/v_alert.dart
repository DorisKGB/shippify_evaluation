import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../models/m_device_view.dart';
import '../../utils/style/app_color.dart';
import '../device/bloc/b_device.dart';

class VAlertDialog extends StatefulWidget {
  const VAlertDialog({Key? key, required this.mDeviceView, required this.bloc}) : super(key: key);
  final MDeviceView mDeviceView;
  final BDevice bloc;
  @override
  State<VAlertDialog> createState() => _VAlertDialogState();
}

class _VAlertDialogState extends State<VAlertDialog> {
  late TextEditingController controller;
  String text = '';
  String subject = '';
  

  @override
  void initState() {    
    controller = TextEditingController();
    controller.text = widget.mDeviceView.device!.name ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Expanded(
              child: Text(
            'Device detail',
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
          )),
          IconButton(
              onPressed: () {
                text =
                    '${widget.mDeviceView.device?.name} ${widget.mDeviceView.device?.macAddres}';
                _shareDevice(context);
              },
              icon: const Icon(Icons.share, color: AppColor.primary))
        ],
      ),
      content: SingleChildScrollView(child: bodyDialog(widget.mDeviceView)),
      actions: <Widget>[
        TextButton(
          child: const Text('Back'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        widget.mDeviceView.save
            ? TextButton(
                child: const Text('Update'),
                onPressed: () {
                  widget.bloc.saveDevices(widget.mDeviceView);
                  Navigator.of(context).pop();
                },
              )
            : TextButton(
                child: const Text('Add'),
                onPressed: () {
                  widget.bloc.saveDevices(widget.mDeviceView);
                  Navigator.of(context).pop();
                },
              )
      ],
    );
  }

  Column bodyDialog(MDeviceView mDeviceView) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
//                  icon: Icon(Icons.person),
            hintText: 'Nombre de dispositivo',
            labelText: 'Nombre de dispositivo',
          ),
          controller: controller,
          onChanged: (String value) {
            mDeviceView.device?.name = value;
          },
        ),
        ListTile(
          title: const Text('Distance'),
          subtitle: Text('${mDeviceView.device!.distance}'),
        ),
        ListTile(
          title: const Text('Device id'),
          subtitle: Text(mDeviceView.device!.macAddres ?? ""),
        )
      ],
    );
  }

  void _shareDevice(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      text,
      subject: subject,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
