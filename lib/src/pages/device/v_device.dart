import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shippify_evaluation/src/models/m_device_view.dart';
import 'package:shippify_evaluation/src/pages/device/bloc/b_device.dart';
import 'package:shippify_evaluation/src/utils/bloc_pattern/bloc_provider.dart';
import 'package:shippify_evaluation/src/utils/style/app_color.dart';

class VDevice extends StatefulWidget {
  const VDevice({Key? key}) : super(key: key);

  @override
  State<VDevice> createState() => _VDeviceState();
}

class _VDeviceState extends State<VDevice> {
  late BDevice bloc;
  late TextEditingController controller;
  String text = '';
  String subject = '';
  //String? name;
  @override
  void initState() {
    bloc = BlocProvider.of<BDevice>(context);
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Lista de dispositivos",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      )),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          child: StreamBuilder<List<MDeviceView>?>(
              stream: bloc.outListDevice,
              initialData: null,
              builder: (context, snapshot) {    
                if (snapshot.hasError) {
                  
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return const Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator()));
                }                
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return itemList(snapshot.data![i], i);
                    },
                  ),
                );
              }),
        ),
        ElevatedButton(
          onPressed: () {
            bloc.getAllDevices();
          },
          child: const Text('Buscar de nuevo'),
        ),
      ]),
    );
  }

  ListTile itemList(MDeviceView mDeviceView, int i) {
    return ListTile(
      title: Text(mDeviceView.device?.name.toString() ?? ""),
      trailing: mDeviceView.save
          ? IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                bloc.deleteDeviceLocal(mDeviceView);
              })
          : Container(width: 0),
      onTap: () {
        _showMyDialog(mDeviceView);
      },
    );
  }

  Future<void> _showMyDialog(MDeviceView mDeviceView) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        controller.text = mDeviceView.device!.name ?? "";
        return AlertDialog(
          title: Row(
            children: [
              const Expanded(
                  child: Text(
                'Detalle del dispositivo',
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
              )),
              IconButton(
                  onPressed: () {
                    text =
                        '${mDeviceView.device?.name} ${mDeviceView.device?.macAddres}';
                    _shareDevice(context);
                  },
                  icon: const Icon(Icons.share, color: AppColor.primary))
            ],
          ),
          content: SingleChildScrollView(child: bodyDialog(mDeviceView)),
          actions: <Widget>[
            TextButton(
              child: const Text('Atras'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            mDeviceView.save
                ? TextButton(
                    child: const Text('Actualizar'),
                    onPressed: () {
                      bloc.saveDevices(mDeviceView);
                      Navigator.of(context).pop();
                    },
                  )
                : TextButton(
                    child: const Text('Agregar'),
                    onPressed: () {
                      bloc.saveDevices(mDeviceView);
                      Navigator.of(context).pop();
                    },
                  )
          ],
        );
      },
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
          title: const Text('Distancia'),
          subtitle: Text(mDeviceView.device!.distance ?? ""),
        ),
        ListTile(
          title: const Text('Id dispositivo'),
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
