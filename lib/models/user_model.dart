// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/foundation.dart';

class UserModel {
  DateTime? pickedDate;

  String? username;
  String email =''; // Default empty string or ensure it's always assigned before use
  String? phoneNo;
  // String password =''; // Initialized with default value, so `late` is not needed

  String? dob;
  late String uid; // Ensure this is assigned before accessed
  bool? isAuthenticated;
  String? gender;
  String? religion;

  String? category;
  String? educationDetail;

  String? state;
  String? district;
  String? subDivision;
  String? areaRoU;
  int? pincode;
  String? gaurdian;
  String? education;
  bool? istraining;
  String? training;

  bool? employmentStatus;
  String? occupation;
  List<String>? skills;

  UserModel({
    required this.username,
    required this.email,
    required this.phoneNo,
    // required this.password,
    required this.dob,
    required this.uid,
    required this.isAuthenticated,
    required this.gender,
    required this.religion,
    required this.category,
    required this.state,
    required this.district,
    required this.subDivision,
    required this.areaRoU,
    required this.pincode,
    required this.gaurdian,
    required this.education,
    required this.educationDetail,
    required this.istraining,
    required this.training,
    required this.employmentStatus,
    required this.occupation,
    required this.skills,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? phoneNo,
    // String? password,
    String? dob,
    String? uid,
    bool? isAuthenticated,
    String? gender,
    String? religion,
    String? category,
    String? state,
    String? district,
    String? subDivision,
    String? areaRoU,
    int? pincode,
    String? gaurdian,
    String? education,
    String? educationDetail,
    bool? istraining,
    String? training,
    bool? employmentStatus,
    String? occupation,
    List<String>? skills,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      // password: password ?? this.password,
      dob: dob ?? this.dob,
      uid: uid ?? this.uid,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      gender: gender ?? this.gender,
      religion: religion ?? this.religion,
      category: category ?? this.category,
      state: state ?? this.state,
      district: district ?? this.district,
      subDivision: subDivision ?? this.subDivision,
      areaRoU: areaRoU ?? this.areaRoU,
      pincode: pincode ?? this.pincode,
      gaurdian: gaurdian ?? this.gaurdian,
      education: education ?? this.education,
      educationDetail: educationDetail ?? this.educationDetail,
      istraining: istraining ?? this.istraining,
      training: training ?? this.training,
      employmentStatus: employmentStatus ?? this.employmentStatus,
      occupation: occupation ?? this.occupation,
      skills: skills ?? this.skills,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'phoneNo': phoneNo,
      // 'password': password,
      'dob': dob,
      'uid': uid,
      'isAuthenticated': isAuthenticated,
      'gender': gender,
      'religion': religion,
      'category': category,
      'state': state,
      'district': district,
      'subDivision': subDivision,
      'areaRoU': areaRoU,
      'pincode': pincode,
      'gaurdian': gaurdian,
      'education': education,
      'educationDetail': educationDetail,
      'istraining': istraining,
      'training': training,
      'employmentStatus': employmentStatus,
      'occupation': occupation,
      'skills': skills,
    }..removeWhere((key, value) => value == null); // Remove null values
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        username: map['username'] as String,
        email: map['email'] as String,
        phoneNo: map['phoneNo'] as String,
        // password: map['password'] as String,
        dob: map['dob'] as String,
        uid: map['uid'] as String,
        isAuthenticated: map['isAuthenticated'] as bool,
        gender: map['gender'] as String,
        religion: map['religion'] as String,
        category: map['category'] as String,
        state: map['state'] as String,
        district: map['district'] as String,
        subDivision: map['subDivision'] as String,
        areaRoU: map['areaRoU'] as String,
        pincode: map['pincode'] as int,
        gaurdian: map['gaurdian'] as String,
        education: map['education'] as String,
        educationDetail: map['educationDetail'] as String,
        istraining: map['istraining'] as bool,
        training: map['training'] != null ? map['training'] as String : null,
        employmentStatus: map['employmentStatus'] as bool,
        occupation: map['occupation'] as String,
        skills: List<String>.from(
          (map['skills']),
        ));
  }

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, phoneNo: $phoneNo, dob: $dob, uid: $uid, isAuthenticated: $isAuthenticated, gender: $gender, religion: $religion, category: $category, state: $state, district: $district, subDivision: $subDivision, areaRoU: $areaRoU, pincode: $pincode, gaurdian: $gaurdian, education: $education, educationDetail: $educationDetail, istraining: $istraining, training: $training, employmentStatus: $employmentStatus, occupation: $occupation, skills: $skills)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.phoneNo == phoneNo &&
        // other.password == password &&
        other.dob == dob &&
        other.uid == uid &&
        other.isAuthenticated == isAuthenticated &&
        other.gender == gender &&
        other.religion == religion &&
        other.category == category &&
        other.state == state &&
        other.district == district &&
        other.subDivision == subDivision &&
        other.areaRoU == areaRoU &&
        other.pincode == pincode &&
        other.gaurdian == gaurdian &&
        other.education == education &&
        other.educationDetail == educationDetail &&
        other.istraining == istraining &&
        other.training == training &&
        other.employmentStatus == employmentStatus &&
        other.occupation == occupation &&
        listEquals(other.skills, skills);
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        phoneNo.hashCode ^
        // password.hashCode ^
        dob.hashCode ^
        uid.hashCode ^
        isAuthenticated.hashCode ^
        gender.hashCode ^
        religion.hashCode ^
        category.hashCode ^
        state.hashCode ^
        district.hashCode ^
        subDivision.hashCode ^
        areaRoU.hashCode ^
        pincode.hashCode ^
        gaurdian.hashCode ^
        education.hashCode ^
        educationDetail.hashCode ^
        istraining.hashCode ^
        training.hashCode ^
        employmentStatus.hashCode ^
        occupation.hashCode ^
        skills.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
