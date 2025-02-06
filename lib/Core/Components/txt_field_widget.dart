import 'package:flutter/material.dart';
import '../Constants/constants.dart';
import '../Constants/strings.dart';
import '../Theme/colors.dart';

class TextFieldComponentWidget extends StatelessWidget {
  final String hint;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool? isPassword;
  final int? maxLength;
  final int? maxLines;
  final Function()? onTap;
  const TextFieldComponentWidget({super.key,this.textInputType,this.textInputAction,required this.controller, this.isPassword,this.onTap,required this.hint,this.validator, this.maxLength,this.maxLines});

  @override
  Widget build(BuildContext context)
  {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: textInputType ?? TextInputType.text,
        obscureText: isPassword ?? false,
        onTap: onTap != null ? onTap!() : null,
        textInputAction: textInputAction ?? TextInputAction.next,
        maxLength: maxLength,
        maxLines: maxLines ?? 1,
        style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.kBlack),
        validator: validator != null ? validator! : (input){
          if( input == null || (input.isEmpty) )
          {
            return "Enter $hint";
          }
          else
          {
            return null;
          }
        },
        decoration: InputDecoration(
          contentPadding: AppConstants.kContainerPadding,
          enabled: onTap != null ? false : true,
          enabledBorder: AppConstants.kEnabledInputBorder,
          focusedBorder: AppConstants.kFocusedInputBorder,
          fillColor: AppColors.kGrey,
          filled: true,
          errorBorder: AppConstants.kErrorInputBorder,
          disabledBorder: AppConstants.kEnabledInputBorder,
          focusedErrorBorder: AppConstants.kErrorInputBorder,
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xff616161)),
        ),
      ),
    );
  }
}

class TxtFieldOfPasswordWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputAction? txtInputAction;
  const TxtFieldOfPasswordWidget({super.key, required this.controller,required this.hint, this.txtInputAction});

  @override
  Widget build(BuildContext context) {
    return TextFieldComponentWidget(
        hint: "Password",
        validator: (input){
          if( input == null || (input.isEmpty) )
          {
            return "Enter your password.";
          }
          else if ( input.isNotEmpty && input.length < 8 )
          {
            return AppStrings.kPasswordMustAtLestEightCharacterMessage;
          }
          else
          {
            return null;
          }
        },
        textInputAction: txtInputAction ?? TextInputAction.done,
        controller: controller,
        isPassword: true
    );
  }
}

class UploadMediaTextFieldWidget extends StatelessWidget {
  final String baseName;
  const UploadMediaTextFieldWidget({super.key,required this.baseName});

  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 14),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: AppConstants.kMainRadius,
          border: AppConstants.kMainBorder,
        color: AppColors.kGrey
      ),
      child: Text(baseName,maxLines: 1,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: AppColors.kBlack),overflow: TextOverflow.ellipsis),
    );
  }
}