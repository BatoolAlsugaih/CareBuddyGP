class BabbysitterMultiMediaModel{
  final String identification;
  final String securityClearance;
  final String medicalHistory;
  final String? certificates;
  final String? profileImage;
  final String? introVideo;

  BabbysitterMultiMediaModel({
    required this.identification,
    required this.securityClearance,
    required this.medicalHistory,
    required this.certificates,
    required this.profileImage,
    required this.introVideo,
  });

  Map<String, dynamic> toJson() {
    return {
      'identification': identification,
      'securityClearance': securityClearance,
      'medicalHistory': medicalHistory,
      'certificates': certificates,
      'profileImage': profileImage,
      'introVideo': introVideo,
    };
  }

  factory BabbysitterMultiMediaModel.fromJson({required dynamic json}) => BabbysitterMultiMediaModel(
    identification: json['identification'],
    securityClearance: json['securityClearance'],
    medicalHistory: json['medicalHistory'],
    certificates: json['certificates'],
    profileImage: json['profileImage'],
    introVideo: json['introVideo'],
  );
}