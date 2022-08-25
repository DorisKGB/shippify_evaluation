import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/m_setting.dart';
import '../../utils/bloc_pattern/bloc_base.dart';

class BSettings extends BlocBase{
  BSettings();

  final BehaviorSubject<MSetting> _setting = BehaviorSubject<MSetting>();
  MSetting get setting => _setting.valueOrNull ?? MSetting();
  Function(MSetting) get inSetting => _setting.sink.add;
  Stream<MSetting> get outSetting => _setting.stream;

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Dot not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _setting.value.themeMode) return;

    // Otherwise, store the new theme mode in memory
    setting.themeMode = newThemeMode;
    inSetting(setting);
  }
  
  @override
  void dispose() {
    _setting.close();
  }
}
