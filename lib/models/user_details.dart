// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetails {
  final String email;
  final String name;
  UserDetails({
    required this.email,
    required this.name,
  });

  UserDetails copyWith({
    String? email,
    String? name,
  }) {
    return UserDetails(
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetails.fromJson(String source) =>
      UserDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserDetails(email: $email, name: $name)';

  @override
  bool operator ==(covariant UserDetails other) {
    if (identical(this, other)) return true;

    return other.email == email && other.name == name;
  }

  @override
  int get hashCode => email.hashCode ^ name.hashCode;
}

class UserDetailsNotifier extends StateNotifier<UserDetails> {
  UserDetailsNotifier(super.state);

  void updateName(String newName) {
    state = state.copyWith(name: newName);
  }
   void updateEmail(String newEmail) {
    state = state.copyWith(email: newEmail);
  }
}
