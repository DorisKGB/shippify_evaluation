// Generic Interface for all BLoCs
import 'package:flutter/material.dart';

import '../mixin/action_view_screen.dart';
import 'bloc_base.dart';


class BlocProvider<T extends BlocBase> extends StatefulWidget {
  const BlocProvider({
    Key? key,
    required this.child,
    required this.blocBuilder,
    this.blocDispose,
  }) : super(key: key);

  final Widget child;
  final BlocBuilder<T> blocBuilder;
  final BlocDisposer<T>? blocDispose;

  @override
  State<BlocProvider<T>> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    _BlocProviderInherited<T>? provider = context
        .getElementForInheritedWidgetOfExactType<_BlocProviderInherited<T>>()
        ?.widget as _BlocProviderInherited<T>?;

    return provider!.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> with ViewExecute {
  late T bloc;

  @override
  void initState() {
    super.initState();
    bloc = widget.blocBuilder();
    // setup action view to show messages
    initActionView(context: context, stream: bloc.outView);
  }

  @override
  void dispose() {
    if (widget.blocDispose != null) {
      widget.blocDispose!(bloc);
    } 
    bloc.disposeActionView();
    disposeViewExecute();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited<T>(
      bloc: bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  const _BlocProviderInherited({
    Key? key,
    required Widget child,
    required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) =>
      oldWidget != bloc;
}
