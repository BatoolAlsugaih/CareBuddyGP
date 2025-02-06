import 'package:carebuddy/Controller/Auth/auth_cubit.dart';
import 'package:carebuddy/Core/Components/txt_field_widget.dart';
import 'package:carebuddy/Core/Constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Controller/Auth/auth_state.dart';
import '../../../Core/Components/custom_btn_widgets.dart';
import '../../../Core/Constants/constants.dart';
import '../../../Core/Theme/colors.dart';
import '../../../Models/baby_sitter_model.dart';
import 'choose_image_widget.dart';

class ProfileCustomizationColumnWidget extends StatelessWidget {
  final AuthCubit cubit;
  final TextEditingController bioCtr;
  final GlobalKey<FormState> profileCustomizationFormKey;
  final TextEditingController fNameCtr;
  final TextEditingController lNameCtr;
  final TextEditingController emailCtr;
  final TextEditingController phoneCtr;
  final TextEditingController cityCtr;
  final TextEditingController nationalityCtr;
  final TextEditingController passwordCtr;
  const ProfileCustomizationColumnWidget({super.key, required this.cubit, required this.bioCtr, required this.profileCustomizationFormKey, required this.fNameCtr, required this.lNameCtr, required this.emailCtr, required this.phoneCtr, required this.cityCtr, required this.nationalityCtr, required this.passwordCtr});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: profileCustomizationFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Identification and Security",style: TextStyle(fontSize: 22,color: AppColors.kBlack)),
          22.vrSpace,
          BlocBuilder<AuthCubit,AuthStates>(
              buildWhen: (past,current) => current is GetProfileImageState,
              builder: (context,state) {
              return Center(
                child: GestureDetector(
                  onTap: ()=> cubit.getProfileImage(),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Container(
                        height: 110,
                        width: 110,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.kMain)
                        ),
                        child: cubit.profileImage != null ? Image.file(cubit.profileImage!,fit: BoxFit.cover) : Icon(Icons.image,color: AppColors.kGreen,size: 46),
                      ),
                      Container(
                        height: 30,width: 30,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.kMain
                        ),
                        child: Image.asset("assets/images/edit.png"),
                      )
                    ],
                  ),
                ),
              );
            }
          ),
          22.vrSpace,
          TextFieldComponentWidget(controller: bioCtr, hint: "Bio | Optional",textInputAction: TextInputAction.done),
          BlocBuilder<AuthCubit,AuthStates>(
              buildWhen: (past,current) => current is GetIntroVideoState,
              builder: (context,state) {
                return ChooseFileMediaWidget(
                    title: "Video introduction",
                    file: cubit.introVideo,
                    isOptional: true,
                    onTap: ()=> cubit.getIntroVideo(),
                    subTitle: "Upload a video introducing yourself"
                );
              }
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: BlocBuilder<AuthCubit,AuthStates>(
                buildWhen: (past,current) => current is ChangeIndexOfRegisterContentShownState || current is CreateAccountUsingEmailLoadingState || current is CreateAccountUsingEmailWithFailureState || current is UploadMainDataOfUserWithFailureState || current is UploadMainDataOfUserSuccessfullyState,
                builder: (context,state) {
                return BtnWidget(
                    onTap: () async {
                      cubit.createAccount(email: emailCtr.text.trim(),context: context, password: passwordCtr.text,fName: fNameCtr.text.trim(), lname: lNameCtr.text.trim(), phone: phoneCtr.text.trim(), city: cityCtr.text.trim(), nationality: nationalityCtr.text.trim(),bio: bioCtr.text.trim());
                    },
                    showLoading: state is CreateAccountUsingEmailLoadingState,
                    title: "Confirm"
                );
              }
            ),
          )
        ],
      ),
    );
  }
}
