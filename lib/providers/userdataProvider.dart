import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login/models/user_details.dart';

final userDetailsProvider = StateNotifierProvider((ref) {
  return UserDetailsNotifier(
    UserDetails(email: "", name: ""),
  );
});
