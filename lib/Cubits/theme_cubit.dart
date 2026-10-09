import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  // البداية بالوضع الفاتح Light Mode
  ThemeCubit() : super(ThemeMode.light);

  // دالة التبديل بين Dark و Light
  void toggleTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
    }
  }

  bool get isDarkMode => state == ThemeMode.dark;
}