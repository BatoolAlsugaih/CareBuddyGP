import 'package:flutter/material.dart';

import '../Constants/constants.dart';
import '../Theme/colors.dart';

class IconBtnWidget extends StatelessWidget {
  final IconData iconData;
  final Function() onTap;
  final Color? color;
  final double? size;
  const IconBtnWidget({super.key,required this.iconData,required this.onTap,this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap,child: Icon(iconData,size : size,color: color ?? AppColors.kMain));
  }
}

class BtnWidget extends StatelessWidget {
  final void Function()? onTap;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? txtColor;
  final double? radiusValue;
  final double? minWidth;
  final double? height;
  final bool? showLoading;
  final String? title;
  const BtnWidget({super.key,required this.onTap,this.minWidth,this.borderColor, this.radiusValue, this.height, required this.title, this.backgroundColor, this.txtColor, this.showLoading});

  @override
  Widget build(BuildContext context){
    return MaterialButton(
      onPressed: showLoading != null && showLoading == true ? (){} : onTap,
      elevation: 0,
      height: height ?? 46,
      minWidth: minWidth,
      highlightElevation: 0,
      disabledColor: onTap == null ? Colors.grey : null,
      color: backgroundColor ?? AppColors.kMain,
      shape: RoundedRectangleBorder(
          borderRadius: radiusValue != null ? BorderRadius.circular(radiusValue!) : AppConstants.kMainRadius,
          side: BorderSide(color: borderColor ?? Colors.transparent)
      ),
      child: Align(
          alignment: Alignment.center,
          child: Builder(
            builder: (context){
              // TODO: showLoading != null && showLoading == true => when loading
              if( showLoading != null && showLoading == true ){
                return SizedBox(
                  height: 26,
                  width: 26,
                  child: CircularProgressIndicator(color: txtColor ?? AppColors.kWhite,strokeWidth: 2.4),
                );
              }
              else
              {
                return Text(title!,style: TextStyle(fontSize: 14,fontWeight:FontWeight.w700,color : txtColor ?? AppColors.kWhite));
              }
            },
          )
      ),
    );
  }
}

class CustomBtnWidget extends StatelessWidget {
  final void Function()? onTap;
  final Color? borderColor;
  final double? radiusValue;
  final double? minWidth;
  final double? height;
  final Widget widget;
  final Color? backgroundColor;
  final bool? withoutBackground;
  const CustomBtnWidget({super.key,required this.onTap,this.minWidth,this.borderColor, this.radiusValue, this.height,this.withoutBackground, required this.widget, this.backgroundColor});

  @override
  Widget build(BuildContext context){
    return MaterialButton(
        onPressed: onTap,
        elevation: 0,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        height: height ?? 46,
        minWidth: minWidth,
        highlightElevation: 0,
        color: withoutBackground != null ? Colors.transparent : backgroundColor ?? AppColors.kMain,
        shape: RoundedRectangleBorder(
            borderRadius: radiusValue != null ? BorderRadius.circular(radiusValue!) : AppConstants.kMainRadius,
            side: BorderSide(color: borderColor ?? Colors.transparent)
        ),
        child: widget
    );
  }
}

class TextBtnWidget extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color? txtColor;
  final double? txtSize;
  const TextBtnWidget({super.key, required this.title, required this.onTap, this.txtColor, this.txtSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(title,style: TextStyle(fontSize: txtSize ?? 14,fontWeight:FontWeight.w700,color : txtColor ?? AppColors.kBlack)),
    );
  }
}