import 'babysitter_multi_media_model.dart';

class BabySitter{
  final String fName;
  final String lname;
  final String email;
  final String phone;
  final String city;
  final String nationality;
  final bool available;
  final int pricePerHour;
  final String? bio;
  final BabbysitterMultiMediaModel multiMedia;

  BabySitter({
    required this.fName,
    required this.lname,
    required this.email,
    required this.phone,
    required this.city,
    required this.nationality,
    required this.bio,
    required this.available,
    required this.pricePerHour,
    required this.multiMedia
  });

  Map<String, dynamic> toJson() {
    return {
      'fName': fName,
      'lname': lname,
      'email': email,
      'phone': phone,
      'city': city,
      'nationality': nationality,
      'bio': bio != null && bio!.isNotEmpty ? bio : null,
      'available': available,
      'pricePerHour': pricePerHour,
      'multiMedia': multiMedia.toJson()
    };
  }

  factory BabySitter.fromJson({required dynamic json}) => BabySitter(
    fName: json['fName'],
    lname: json['lname'],
    email: json['email'],
    phone: json['phone'],
    city: json['city'],
    nationality: json['nationality'],
    multiMedia: BabbysitterMultiMediaModel.fromJson(json: json['multiMedia']),
    bio: json['bio'],
    available: json['available'],
    pricePerHour: json['pricePerHour'],
  );
}