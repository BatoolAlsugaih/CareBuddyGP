import 'dart:io';
import 'package:carebuddy/Core/Constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Controller/Auth/auth_cubit.dart';
import '../Theme/colors.dart';

class AppConstants{
  static Orientation kGetDeviceOrientation(BuildContext context) => MediaQuery.of(context).orientation;
  static String kGetFileName(File file) => file.path.split('/').last;
  static dynamic kProviders = [
    BlocProvider(create: (context) => AuthCubit()),
  ];
  static Widget Function(BuildContext, int) kSeparatorBuilder() => (context,index) => 10.vrSpace;
  static BorderRadius kMainRadius = BorderRadius.circular(10);
  static BorderRadius kMaxRadius = BorderRadius.circular(22);
  static EdgeInsets kContainerPadding = const EdgeInsets.all(14);
  static EdgeInsets kScaffoldPadding = const EdgeInsets.all(14);
  static EdgeInsets kListViewPadding = const EdgeInsets.only(bottom: 10);
  static BoxBorder kMainBorder = Border.all(color: AppColors.kBorder);
  static InputBorder kEnabledInputBorder = OutlineInputBorder(borderRadius: AppConstants.kMainRadius, borderSide: BorderSide(color: AppColors.kBorder));
  static InputBorder kFocusedInputBorder = OutlineInputBorder(borderRadius: AppConstants.kMainRadius, borderSide: BorderSide(color: AppColors.kMain));
  static InputBorder kErrorInputBorder = OutlineInputBorder(borderRadius: AppConstants.kMainRadius, borderSide: BorderSide(color: AppColors.kRed));
  static BoxBorder kSkeletonLoadingBorder = Border.all(color: AppColors.kBorder);
}