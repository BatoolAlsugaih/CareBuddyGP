import 'package:flutter/material.dart';

void showSnackBarWidget({required String message,required bool successOrNot,required BuildContext context}) {
  SnackBar snackBarItem() => SnackBar(
    elevation: 0,
    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 14),
    content: Align(
        alignment:AlignmentDirectional.topStart,
        child: Text(message,style:const TextStyle(fontSize: 14,fontWeight: FontWeight.bold))),backgroundColor:  successOrNot ? Colors.black : Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBarItem());
}