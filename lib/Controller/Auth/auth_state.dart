abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class ChangeIndexOfRegisterContentShownState extends AuthStates {}
class ChangePricePerHourState extends AuthStates {}
class ChangeAvailabilityStatusState extends AuthStates {}
class GetIdentificationImageState extends AuthStates {}
class GetIntroVideoState extends AuthStates {}
class GetProfileImageState extends AuthStates {}
class GetSecurityClearanceMediaState extends AuthStates {}
class GetMedicalHistoryMediaState extends AuthStates {}
class GetCertificateMediaState extends AuthStates {}

class CreateAccountUsingEmailLoadingState extends AuthStates {}
class CreateAccountUsingEmailWithFailureState extends AuthStates {}

class UploadMainDataOfUserSuccessfullyState extends AuthStates {}
class UploadMainDataOfUserWithFailureState extends AuthStates {}