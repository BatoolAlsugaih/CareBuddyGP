import 'dart:io';
import 'dart:math';
import 'package:carebuddy/Core/Constants/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService{
  static const kBaseUrl = "https://fylvcebbbqvzvtjafhar.supabase.co";
  static const String kBucketName = "Uploads";
  static const String kServiceRole = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ5bHZjZWJiYnF2enZ0amFmaGFyIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczNzUwODU0MiwiZXhwIjoyMDUzMDg0NTQyfQ.gtTSv7HjF4Z2q3UuuESxXhq12To_8T_GCAz5hT64ECE";
  static const kBaseUrlOfFileAccessOnSpecificBucket = "$kBaseUrl/storage/v1/object/public/";
  static Future<void> kInitialize() async {
    await Supabase.initialize(
      url: kBaseUrl,
      anonKey: kServiceRole
    );
  }
  static SupabaseClient kSupabaseClient = Supabase.instance.client;
  static Future<String> kUploadFile(File file) async {
    final bool fileExists = await kSupabaseClient.storage.from(kBucketName).list().then((files) => files.any((f) => f.name == AppConstants.kGetFileName(file)));
    return "$kBaseUrlOfFileAccessOnSpecificBucket${fileExists ? await kSupabaseClient.storage.from(kBucketName).update(AppConstants.kGetFileName(file), file, fileOptions: const FileOptions(cacheControl: '3600', upsert: false)) : await kSupabaseClient.storage.from(kBucketName).upload("${Random().nextDouble()*1000000000}${AppConstants.kGetFileName(file)}", file, fileOptions: const FileOptions(cacheControl: '3600', upsert: false))}";
  }
}