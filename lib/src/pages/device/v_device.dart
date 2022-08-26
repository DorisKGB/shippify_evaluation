import 'package:flutter/material.dart';
import 'package:shippify_evaluation/src/models/m_device_view.dart';
import 'package:shippify_evaluation/src/pages/device/bloc/b_device.dart';
import 'package:shippify_evaluation/src/utils/bloc_pattern/bloc_provider.dart';
import 'package:shippify_evaluation/src/utils/style/app_color.dart';

import '../alert/v_alert.dart';

class VDevice extends StatefulWidget {
  const VDevice({Key? key}) : super(key: key);

  @override
  State<VDevice> createState() => _VDeviceState();
}

class _VDeviceState extends State<VDevice> {
  late BDevice bloc;

  //String? name;
  @override
  void initState() {
    bloc = BlocProvider.of<BDevice>(context);    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Devices list",
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
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.sync_problem,
                            size: MediaQuery.of(context).size.height * 0.1),
                        const Text(
                            'We have problems getting devices with bluetooth',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip),
                      ]),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return const Center(
                      child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator()));
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
          child: const Text('Search again'),
        ),
      ]),
    );
  }

  ListTile itemList(MDeviceView mDeviceView, int i) {
    return ListTile(
      title: Text(mDeviceView.device?.name.toString() ?? ""),
      subtitle: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              mDeviceView.isAvailable
              ? const Icon(Icons.bluetooth, size: 17, color: AppColor.secundary)
              : Container(width: 0),    
              Text(bloc.getDistance(mDeviceView.device!.distance!))
            ],
          )),
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
        return VAlertDialog(mDeviceView: mDeviceView, bloc: bloc);
      },
    );
  }
}
