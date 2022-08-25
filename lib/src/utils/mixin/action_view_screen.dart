import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/m_action_view.dart';


mixin ActionView {
  final viewCtrl = PublishSubject<MActionView>();

  void _inView(MActionView actionView) {
    if (!viewCtrl.isClosed) {
      viewCtrl.sink.add(actionView);
    }
  }

  Stream<MActionView> get outView => viewCtrl.stream;

  void showMessage(String message, {bool isError = false}) {
    _inView(MActionView.messageSuccess(message));
  }

  void showLoading(String message) {
    MActionView mActionView = MActionView.showLoading(message);
    _inView(mActionView);
  }

  void hideLoading() {
    MActionView mActionView = MActionView.hideLoading();
    _inView(mActionView);
  }

  void disposeActionView() {
    viewCtrl.close();
  }
}

mixin ViewExecute {
  StreamSubscription? listenView;

  void initActionView(
      {required BuildContext context, required Stream<MActionView> stream}) {
    listenView = stream.listen((MActionView view) {
      _execute(context: context, view: view);
    });
  }

  void _execute({required BuildContext? context, required MActionView view}) {
    switch (view.type) {
      case TypeActionView.error:
        _showMessage(context!, view.message!, false);
        break;
      case TypeActionView.success:
        _showMessage(context!, view.message!, false);
        break;
      case TypeActionView.showLoading:
        _showDialog(context!, view.message!);
        break;
      case TypeActionView.hideLoading:
        Navigator.pop(context!);
        break;
    }
  }

  void _showMessage(BuildContext context, String message,
      [bool success = true]) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void disposeViewExecute() {
    listenView?.cancel();
  }

  _showDialog(BuildContext ctx, String msj) {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(children: [
                const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    )),
                const SizedBox(width: 16),
                Expanded(child: Text(msj))
              ]),
            ),
          );
        });
  }
}
