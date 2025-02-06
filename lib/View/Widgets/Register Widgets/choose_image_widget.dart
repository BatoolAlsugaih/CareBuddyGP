import 'dart:io';
import 'package:carebuddy/Core/Constants/extensions.dart';
import 'package:flutter/material.dart';
import '../../../Core/Components/txt_field_widget.dart';
import '../../../Core/Constants/constants.dart';
import '../../../Core/Theme/colors.dart';

class ChooseImageWidget extends StatelessWidget {
  final File? file;
  final Function() onTap;
  final String title;
  final String subTitle;
  const ChooseImageWidget({super.key,required this.file, required this.title,required this.onTap, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
              children: [
                TextSpan(text: "$title\n"),
                TextSpan(text: subTitle,style: const TextStyle(color: Color(0xff616161),fontSize: 14)),
              ]
          ),
          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.kBlack),
        ),
        10.vrSpace,
        GestureDetector(
          onTap: ()=> onTap(),
          child: Builder(
            builder: (context){
              if( file != null )
              {
                return Container(
                  height: 122,
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: AppConstants.kMainRadius
                  ),
                  child: Image.file(file!,fit: BoxFit.cover),
                );
              }
              else
              {
                return Container(
                  padding: AppConstants.kContainerPadding,
                  height: 46,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: AppConstants.kMainRadius,
                      color: AppColors.kMain
                  ),
                  child: Image.asset("assets/images/upload.png",height: 34,width: 34),
                );
              }
            },
          ),
        ),
        14.vrSpace
      ],
    );
  }
}

class ChooseFileMediaWidget extends StatelessWidget {
  final File? file;
  final Function() onTap;
  final String title;
  final String subTitle;
  final bool isOptional;
  const ChooseFileMediaWidget({super.key,required this.file, required this.title,required this.onTap, required this.subTitle, this.isOptional = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
              children: [
                TextSpan(text: isOptional ? title : "$title\n"),
                if( isOptional )
                  const TextSpan(text: " \"Optional\"\n",style: TextStyle(color: Color(0xff616161),fontSize: 14)),
                TextSpan(text: subTitle,style: const TextStyle(color: Color(0xff616161),fontSize: 14)),
              ]
          ),
          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.kBlack),
        ),
        10.vrSpace,
        GestureDetector(
          onTap: ()=> onTap(),
          child: Builder(
            builder: (context){
              if( file != null )
              {
                return UploadMediaTextFieldWidget(baseName: AppConstants.kGetFileName(file!));
              }
              else
              {
                return Container(
                  padding: AppConstants.kContainerPadding,
                  height: 46,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: AppConstants.kMainRadius,
                      color: AppColors.kMain
                  ),
                  child: Image.asset("assets/images/upload.png",height: 34,width: 34),
                );
              }
            },
          ),
        ),
        14.vrSpace
      ],
    );
  }
}
