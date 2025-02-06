import 'package:carebuddy/Controller/Auth/auth_cubit.dart';
import 'package:carebuddy/Core/Components/custom_btn_widgets.dart';
import 'package:carebuddy/Core/Constants/extensions.dart';
import 'package:flutter/material.dart';
import '../../../Core/Components/txt_field_widget.dart';
import '../../../Core/Theme/colors.dart';

class PersonalInfoColumnWidget extends StatelessWidget {
  final GlobalKey<FormState> personalInfoFormKey;
  final AuthCubit cubit;
  final TextEditingController fNameCtr;
  final TextEditingController lNameCtr;
  final TextEditingController emailCtr;
  final TextEditingController phoneCtr;
  final TextEditingController cityCtr;
  final TextEditingController nationalityCtr;
  final TextEditingController passwordCtr;
  const PersonalInfoColumnWidget({super.key, required this.fNameCtr, required this.lNameCtr, required this.emailCtr, required this.phoneCtr, required this.cityCtr, required this.nationalityCtr, required this.passwordCtr, required this.personalInfoFormKey, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: personalInfoFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Personal information",style: TextStyle(fontSize: 22,color: AppColors.kBlack)),
          14.vrSpace,
          Row(
            children: [
              Expanded(child: TextFieldComponentWidget(controller: fNameCtr, hint: "First Name")),
              14.hrSpace,
              Expanded(child: TextFieldComponentWidget(controller: lNameCtr, hint: "Last Name")),
            ],
          ),
          TextFieldComponentWidget(
              controller: emailCtr,
              validator: (input){
                if( input == null || (input.isEmpty) )
                {
                  return "Enter your Email.";
                }
                else if ( input.isNotEmpty && input.contains("@gmail.com") == false )
                  {
                    return "Enter a valid Email.";
                  }
                else
                {
                  return null;
                }
              },
              hint: "Email"
          ),
          TextFieldComponentWidget(
              controller: phoneCtr,
              hint: "Phone",
              validator: (input){
                if( input == null || (input.isEmpty) )
                {
                  return "Enter your Phone number.";
                }
                else if ( input.isNotEmpty && int.tryParse(input) == null )
                {
                  return "Enter a valid Phone number ( Only Digits ).";
                }
                else
                {
                  return null;
                }
              },
              textInputType: TextInputType.number
          ),
          TextFieldComponentWidget(controller: cityCtr, hint: "City"),
          TextFieldComponentWidget(controller: nationalityCtr, hint: "Nationality"),
          TxtFieldOfPasswordWidget(
              controller: passwordCtr,
              hint: "Password",
              txtInputAction: TextInputAction.done
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: BtnWidget(
                onTap: (){
                  if( personalInfoFormKey.currentState!.validate() )
                  {
                    cubit.changeIndexOfRegisterContentShown(true);
                  }
                },
                title: "Confirm"
            ),
          )
        ]
      ),
    );
  }
}
