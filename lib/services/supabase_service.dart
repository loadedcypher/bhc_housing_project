import 'package:bhc_housing_project/config/enviroment.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final supabaseClient = Supabase.instance.client;

  static Future<void> initializeSupabase() async {
    await Supabase.initialize(
        url: EnviromentVariables.supabaseUrl!,
        anonKey: EnviromentVariables.supabaseKey!);
  }
}
