import 'package:carebuddy/Controller/Auth/auth_cubit.dart';
import 'package:carebuddy/Core/Constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Controller/Auth/auth_state.dart';
import '../../../Core/Components/custom_btn_widgets.dart';
import '../../../Core/Components/show_snackbar_widget.dart';
import '../../../Core/Theme/colors.dart';
import 'choose_image_widget.dart';

class ProfessionalInfoColumnWidget extends StatelessWidget {
  final AuthCubit cubit;
  const ProfessionalInfoColumnWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Professional Information",style: TextStyle(fontSize: 22,color: AppColors.kBlack)),
        14.vrSpace,
        BlocBuilder<AuthCubit,AuthStates>(
            buildWhen: (past,current) => current is ChangeAvailabilityStatusState,
            builder: (context,state) {
              return SwitchListTile(
                  value: cubit.availabilityStatus,
                  contentPadding: EdgeInsets.zero,
                  activeTrackColor: AppColors.kMain,
                  inactiveTrackColor: AppColors.kGrey,
                  title: Text("Availability status :",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.kBlack)),
                  onChanged: (value) => cubit.changAvailabilityStatus()
              );
            }
        ),
        BlocBuilder<AuthCubit,AuthStates>(
            buildWhen: (past,current) => current is ChangePricePerHourState,
            builder: (context,state) {
              return Container(
                margin: const EdgeInsets.only(bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Price per hour : ${cubit.pricePerHour != 0 ? "${cubit.pricePerHour} SAR" : ""}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.kBlack)),
                    Slider.adaptive(
                        value: cubit.pricePerHour.toDouble(),
                        max: 200,
                        min: 0,
                        activeColor: AppColors.kMain,
                        onChanged: (value)=> cubit.changePricePerHour(value.toInt())
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("0 SAR",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.kBlack)),
                        Text("200 SAR",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.kBlack)),
                      ],
                    )
                  ],
                ),
              );
            }
        ),
        BlocBuilder<AuthCubit,AuthStates>(
            buildWhen: (past,current) => current is GetCertificateMediaState,
            builder: (context,state) {
              return ChooseFileMediaWidget(
                  title: "Additional certificates",
                  file: cubit.certificateMedia,
                  isOptional: true,
                  onTap: ()=> cubit.getCertificateMedia(),
                  subTitle: "Upload a valid certificate,(e.g CPR training, first aid)"
              );
            }
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: BtnWidget(
              onTap: (){
                if( cubit.pricePerHour != 0 )
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
