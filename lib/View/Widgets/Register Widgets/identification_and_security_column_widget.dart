import 'package:carebuddy/Controller/Auth/auth_cubit.dart';
import 'package:carebuddy/Controller/Auth/auth_state.dart';
import 'package:carebuddy/Core/Components/txt_field_widget.dart';
import 'package:carebuddy/Core/Constants/constants.dart';
import 'package:carebuddy/Core/Constants/extensions.dart';
import 'package:carebuddy/View/Widgets/Register%20Widgets/choose_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/Components/custom_btn_widgets.dart';
import '../../../Core/Components/show_snackbar_widget.dart';
import '../../../Core/Theme/colors.dart';

class IdentificationAndSecurityColumnWidget extends StatelessWidget {
  final AuthCubit cubit;
  const IdentificationAndSecurityColumnWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Identification and Security",style: TextStyle(fontSize: 22,color: AppColors.kBlack)),
        14.vrSpace,
        BlocBuilder<AuthCubit,AuthStates>(
          buildWhen: (past,current) => current is GetIdentificationImageState,
          builder: (context,state) {
            return ChooseImageWidget(
                title: "Identification",
                file: cubit.identificationImage,
                onTap: ()=> cubit.getIdentificationImage(),
                subTitle: "Upload your ID document"
            );
          }
        ),
        BlocBuilder<AuthCubit,AuthStates>(
          buildWhen: (past,current) => current is GetSecurityClearanceMediaState,
          builder: (context,state){
            return ChooseFileMediaWidget(
                title: "Security Clearance",
                file: cubit.securityClearanceMedia,
                onTap: ()=> cubit.getSecurityClearanceMedia(),
                subTitle: "Upload your safety certification or proof of background check."
            );
          }
        ),
        BlocBuilder<AuthCubit,AuthStates>(
            buildWhen: (past,current) => current is GetMedicalHistoryMediaState,
            builder: (context,state) {
              return ChooseFileMediaWidget(
                  title: "Medical History",
                  file: cubit.medicalHistoryMedia,
                  onTap: ()=> cubit.getMedicalHistoryMedia(),
                  subTitle: "Upload a health verification document (e.g., medical report)"
              );
            }
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: BtnWidget(
              onTap: (){
                if( cubit.identificationImage != null && cubit.securityClearanceMedia != null && cubit.medicalHistoryMedia != null )
                {
                  cubit.changeIndexOfRegisterContentShown(true);
                }
                else
                {
                  showSnackBarWidget(message: "Complete your data to continue", successOrNot: false, context: context);
                }
              },
              title: "Confirm"
          ),
        )
      ],
    );
  }
}
