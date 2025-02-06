import 'package:carebuddy/Controller/Auth/auth_cubit.dart';
import 'package:carebuddy/Controller/Auth/auth_state.dart';
import 'package:carebuddy/View/Widgets/Register%20Widgets/identification_and_security_column_widget.dart';
import 'package:carebuddy/View/Widgets/Register%20Widgets/personal_info_column_widget.dart';
import 'package:carebuddy/View/Widgets/Register%20Widgets/professional_info_column_widget.dart';
import 'package:carebuddy/View/Widgets/Register%20Widgets/profile_customization_column_widget.dart';
import 'package:carebuddy/View/Widgets/Register%20Widgets/register_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Core/Constants/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _personalInfoFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _profileCustomizationFormKey = GlobalKey<FormState>();
  final TextEditingController _fNameCtr = TextEditingController();
  final TextEditingController _lNameCtr = TextEditingController();
  final TextEditingController _emailCtr = TextEditingController();
  final TextEditingController _phoneCtr = TextEditingController();
  final TextEditingController _cityCtr = TextEditingController();
  final TextEditingController _nationalityCtr = TextEditingController();
  final TextEditingController _passwordCtr = TextEditingController();
  final TextEditingController _bioCtr = TextEditingController();

  @override
  void dispose() {
    _fNameCtr.dispose();
    _lNameCtr.dispose();
    _emailCtr.dispose();
    _phoneCtr.dispose();
    _cityCtr.dispose();
    _nationalityCtr.dispose();
    _passwordCtr.dispose();
    _bioCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthCubit cubit = AuthCubit.getInstance(context);
    return WillPopScope(
      onWillPop: () async {
        if( cubit.indexOfRegisterContentShown > 0 )
          {
            cubit.changeIndexOfRegisterContentShown(false);
            return false;
          }
        else
          {
            return true;
          }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset("assets/images/background_image.png",height: double.infinity,width: double.infinity,fit: BoxFit.cover),
            Column(
                children: [
                  RegisterHeaderWidget(cubit: cubit),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: AppConstants.kScaffoldPadding.copyWith(bottom: 22,top: 0),
                      child: BlocBuilder<AuthCubit,AuthStates>(
                        buildWhen: (past,current) => current is ChangeIndexOfRegisterContentShownState,
                        builder: (context,state){
                          if( cubit.indexOfRegisterContentShown == 0 )
                          {
                            return PersonalInfoColumnWidget(cubit: cubit,personalInfoFormKey: _personalInfoFormKey,fNameCtr: _fNameCtr, lNameCtr: _lNameCtr, emailCtr: _emailCtr, phoneCtr: _phoneCtr, cityCtr: _cityCtr, nationalityCtr: _nationalityCtr, passwordCtr: _passwordCtr);
                          }
                          else if ( cubit.indexOfRegisterContentShown == 1 )
                          {
                            return IdentificationAndSecurityColumnWidget(cubit: cubit);
                          }
                          else if ( cubit.indexOfRegisterContentShown == 2 )
                          {
                            return ProfessionalInfoColumnWidget(cubit: cubit);
                          }
                          else
                          {
                            return ProfileCustomizationColumnWidget(fNameCtr: _fNameCtr, lNameCtr: _lNameCtr, emailCtr: _emailCtr, phoneCtr: _phoneCtr, cityCtr: _cityCtr, nationalityCtr: _nationalityCtr, passwordCtr: _passwordCtr,cubit: cubit,bioCtr: _bioCtr,profileCustomizationFormKey: _profileCustomizationFormKey);
                          }
                        },
                      ),
                    ),
                  ),
                ]
            ),
          ],
        )
      ),
    );
  }
}
