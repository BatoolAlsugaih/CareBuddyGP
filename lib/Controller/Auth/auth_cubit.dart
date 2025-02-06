import 'dart:io';
import 'package:carebuddy/Core/Constants/constants.dart';
import 'package:carebuddy/Core/Constants/firebase_collections.dart';
import 'package:carebuddy/Core/Constants/firebase_exception_code.dart';
import 'package:carebuddy/Core/Services/pick_file_service.dart';
import 'package:carebuddy/Core/Services/supabase_service.dart';
import 'package:carebuddy/Models/babysitter_multi_media_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Core/Components/show_snackbar_widget.dart';
import '../../Models/baby_sitter_model.dart';
import '../../View/Screens/layout_screen.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit getInstance(BuildContext context) => BlocProvider.of<AuthCubit>(context);

  int indexOfRegisterContentShown = 0;
  void changeIndexOfRegisterContentShown(bool plusOrMinus){
    plusOrMinus ? ++indexOfRegisterContentShown : --indexOfRegisterContentShown;
    emit(ChangeIndexOfRegisterContentShownState());
  }

  int pricePerHour = 0;
  void changePricePerHour(int value){
    pricePerHour = value;
    emit(ChangePricePerHourState());
  }

  bool availabilityStatus = true;
  void changAvailabilityStatus(){
    availabilityStatus = !availabilityStatus;
    emit(ChangeIndexOfRegisterContentShownState());
  }

  File? identificationImage;
  File? securityClearanceMedia;
  File? medicalHistoryMedia;
  File? certificateMedia;
  File? profileImage;
  File? introVideo;

  void getIdentificationImage() async {
    await PickFileService.chooseImage().then((file) async {
      if( file != null )
        {
          identificationImage = file;
          emit(GetIdentificationImageState());
        }
    });
  }

  void getSecurityClearanceMedia() async {
    await PickFileService.chooseMedia().then((file) async {
      if (file != null) {
        securityClearanceMedia = file;
        emit(GetSecurityClearanceMediaState());
      }
    });
  }

  void getMedicalHistoryMedia() async {
    await PickFileService.chooseMedia().then((file) async {
      if (file != null) {
        medicalHistoryMedia = file;
        emit(GetMedicalHistoryMediaState());
      }
    });
  }

  void getCertificateMedia() async {
    await PickFileService.chooseMedia().then((file) async {
      if (file != null) {
        certificateMedia = file;
        emit(GetCertificateMediaState());
      }
    });
  }

  void getProfileImage() async {
    await PickFileService.chooseImage().then((file) async {
      if (file != null) {
        profileImage = file;
        emit(GetProfileImageState());
      }
    });
  }

  void getIntroVideo() async {
    await PickFileService.chooseVideo().then((file) async {
      if (file != null) {
        introVideo = file;
        emit(GetIntroVideoState());
      }
    });
  }

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _cloudFirestore = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Future<String?> uploadFileAndReturnUrl({required File file}) async {
    try{
      Reference fileRef = _firebaseStorage.ref().child("Uploads/${AppConstants.kGetFileName(file)}");
      fileRef.putFile(file);
      return await fileRef.getDownloadURL();
    }
    on FirebaseException catch(e){
      debugPrint("Exception ${e.code}");
      return null;
    }
  }

  Future<void> createAccount({required BuildContext context,required String email,required String nationality,required String password,required String fName,required String lname,required String phone,required String city,required String? bio}) async {
    try{
      emit(CreateAccountUsingEmailLoadingState());
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((userCredential) async {
        await uploadMainDataOfUser(context: context,email: email,userID: userCredential.user!.uid,nationality: nationality,password: password,fName: fName,bio: bio,city: city,lname: lname,phone: phone);
      });
    }
    on FirebaseAuthException catch (error){
      if( error.code == FirebaseExceptionCodes.kEmailAlreadyInUse )
        {
          await uploadMainDataOfUser(context: context,email: email,password: password,nationality: nationality,fName: fName,bio: bio,city: city,lname: lname,phone: phone);
        }
      else
        {
          showSnackBarWidget(context: context,successOrNot: false,message: error.code == FirebaseExceptionCodes.kInvalidEmailEntered ? "Invalid Email Entered." : error.code.replaceAll("-"," "));
          emit(CreateAccountUsingEmailWithFailureState());
        }
    }
  }

  Future<void> uploadMainDataOfUser({required String email,required String fName,required String lname,required String nationality,required String phone,required String city,required String? bio,required BuildContext context,String? userID,required String password}) async {
    try{
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(FirebaseCollections.kBabySitter).where('email', isEqualTo: email).get();
      if( querySnapshot.docs.isNotEmpty )
        {
          // TODO: Mean His Data already sent to CloudStore
          showSnackBarWidget(message: "Email already in use, Sign in with it.", successOrNot: false, context: context);
          emit(UploadMainDataOfUserSuccessfullyState());
        }
      else
        {
          BabbysitterMultiMediaModel? multiMediaModel = await uploadMultiMediaOfUserToStorage(context: context);
          if( multiMediaModel != null )
            {
              final BabySitter babySitter = BabySitter(fName: fName, lname: lname, email: email, phone: phone, city: city, nationality: nationality, bio: bio, available: availabilityStatus, pricePerHour: pricePerHour, multiMedia: multiMediaModel);
              String? uid = userID;
              if( uid == null )
              {
                // TODO: ده عشان لو كان عمل login without storing his data on CloudFirestore
                UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: babySitter.email, password: password);
                uid = userCredential.user!.uid;
              }
              await _cloudFirestore.collection(FirebaseCollections.kBabySitter).doc(uid).set(babySitter.toJson());
              showSnackBarWidget(context: context,message: "Account Created Successfully.",successOrNot: true);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const LayoutScreen()),(_)=>false);
              emit(UploadMainDataOfUserSuccessfullyState());
            }
        }
    }
    on FirebaseException catch(error){
      showSnackBarWidget(context: context,successOrNot: false,message: error.code.replaceAll("-", " "));
      emit(UploadMainDataOfUserWithFailureState());
    }
  }

  Future<BabbysitterMultiMediaModel?> uploadMultiMediaOfUserToStorage({required BuildContext context}) async {
    try{
      final BabbysitterMultiMediaModel multiMediaModel = BabbysitterMultiMediaModel(identification: await SupabaseService.kUploadFile(identificationImage!), securityClearance: await SupabaseService.kUploadFile(securityClearanceMedia!), medicalHistory: await SupabaseService.kUploadFile(medicalHistoryMedia!), certificates: certificateMedia != null ? await SupabaseService.kUploadFile(certificateMedia!) : null, profileImage: profileImage != null ? await SupabaseService.kUploadFile(profileImage!) : null, introVideo: introVideo != null ? await SupabaseService.kUploadFile(introVideo!) : null);
      return multiMediaModel;
    }
    catch(e){
      showSnackBarWidget(context: context,successOrNot: false,message: "Check Internet and try again later.");
      emit(UploadMainDataOfUserWithFailureState());
    }
  }
}
