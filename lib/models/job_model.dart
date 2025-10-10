// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

class JobModel {
  final String jobName; //* *
  final String orgainzation; //* *
  final String examName; //* *
  final String? postName; //* *
  final int? vacancyNumber;
  final String? category; //example: contractual basis, full-time post * *
  final String? EligibilityCriteria; //* *
  final String? EducationQualification; //* *
  final int ageLimit; //* *
  final String? selectionProcess; //* *
  final String? applicaitonMode; //* *
  final String? applicationDate; //
  final String? examDate; //* *
  final String? linkNoti; //* *
  final String? linkApplication; //* *
  final String? website; //* *
  final String? additionalInfo;

  final String uid;
  final String description; //* *
  final String createdAt; //
  final bool isTripura;
  final String state; //* *
  final String? contactNo; //
  final String? contactName; //* *
  final String jobLocation; //* *

  final List<dynamic> searchData;

  JobModel({
    required this.jobName,
    required this.additionalInfo,
    required this.orgainzation,
    required this.examName,
    required this.postName,
    required this.vacancyNumber,
    required this.category,
    required this.EligibilityCriteria,
    required this.EducationQualification,
    required this.ageLimit,
    required this.selectionProcess,
    required this.applicaitonMode,
    required this.applicationDate,
    required this.examDate,
    required this.linkNoti,
    required this.linkApplication,
    required this.website,
    required this.uid,
    required this.description,
    required this.createdAt,
    required this.isTripura,
    required this.state,
    this.contactNo,
    this.contactName,
    required this.jobLocation,
    required this.searchData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'additionalInfo': additionalInfo ?? 'N/A',
      'jobName': jobName,
      'orgainzation': orgainzation,
      'examName': examName,
      'postName': postName,
      'vacancyNumber': vacancyNumber,
      'category': category,
      'EligibilityCriteria': EligibilityCriteria,
      'EducationQualification': EducationQualification,
      'ageLimit': ageLimit,
      'selectionProcess': selectionProcess,
      'applicaitonMode': applicaitonMode,
      'applicationDate': applicationDate,
      'examDate': examDate,
      'linkNoti': linkNoti,
      'linkApplication': linkApplication,
      'website': website,
      'uid': uid,
      'description': description,
      'createdAt': createdAt,
      'isTripura': isTripura,
      'state': state,
      'contactNo': contactNo,
      'contactName': contactName,
      'jobLocation': jobLocation,
      'searchData': searchData,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    debugPrint('map' + map.toString());
    return JobModel(
      jobName: map['jobName'] as String,
      additionalInfo: map['additionalInfo'] as String,
      orgainzation: map['orgainzation'] as String,
      examName: map['examName'] as String,
      postName: map['postName'] != null ? map['postName'] as String : null,
      vacancyNumber:
          map['vacancyNumber'] != null ? map['vacancyNumber'] as int : null,
      category: map['category'] != null ? map['category'] as String : null,
      EligibilityCriteria: map['EligibilityCriteria'] != null
          ? map['EligibilityCriteria'] as String
          : null,
      EducationQualification: map['EducationQualification'] != null
          ? map['EducationQualification'] as String
          : null,
      ageLimit: map['ageLimit'] as int,
      selectionProcess: map['selectionProcess'] != null
          ? map['selectionProcess'] as String
          : null,
      applicaitonMode: map['applicaitonMode'] != null
          ? map['applicaitonMode'] as String
          : null,
      applicationDate: map['applicationDate'] != null
          ? map['applicationDate'] as String
          : null,
      examDate: map['examDate'] != null ? map['examDate'] as String : null,
      linkNoti: map['linkNoti'] != null ? map['linkNoti'] as String : null,
      linkApplication: map['linkApplication'] != null
          ? map['linkApplication'] as String
          : null,
      website: map['website'] != null ? map['website'] as String : null,
      uid: map['uid'] as String,
      description: map['description'] as String,
      createdAt: map['createdAt'] as String,
      isTripura: map['isTripura'] as bool,
      state: map['state'] as String,
      contactNo: map['contactNo'] != null ? map['contactNo'] as String : null,
      contactName:
          map['contactName'] != null ? map['contactName'] as String : null,
      jobLocation: map['jobLocation'] as String,
      searchData:
          map['searchData'] is List ? map['searchData'] as List<dynamic> : [],
    );
  }

  // String toJson() => json.encode(toMap());

  // factory JobModel.fromJson(String source) =>
  //     JobModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobModel(jobName: $jobName, orgainzation: $orgainzation, examName: $examName, postName: $postName, vacancyNumber: $vacancyNumber, category: $category, EligibilityCriteria: $EligibilityCriteria, EducationQualification: $EducationQualification, ageLimit: $ageLimit, selectionProcess: $selectionProcess, applicaitonMode: $applicaitonMode, applicationDate: $applicationDate, examDate: $examDate, linkNoti: $linkNoti, linkApplication: $linkApplication, website: $website, uid: $uid, description: $description, createdAt: $createdAt, isTripura: $isTripura, state: $state, contactNo: $contactNo, contactName: $contactName, jobLocation: $jobLocation, additionalInfo : $additionalInfo, searchData: $searchData)';
  }

  JobModel copyWith(
      {String? jobName,
      String? orgainzation,
      String? examName,
      String? postName,
      int? vacancyNumber,
      String? category,
      String? EligibilityCriteria,
      String? EducationQualification,
      int? ageLimit,
      String? selectionProcess,
      String? applicaitonMode,
      String? applicationDate,
      String? examDate,
      String? linkNoti,
      String? linkApplication,
      String? website,
      String? uid,
      String? description,
      String? createdAt,
      bool? isTripura,
      String? state,
      String? contactNo,
      String? contactName,
      String? jobLocation,
      List<dynamic>? searchData}) {
    return JobModel(
        jobName: jobName ?? this.jobName,
        additionalInfo: additionalInfo ?? this.additionalInfo ?? 'N/A',
        orgainzation: orgainzation ?? this.orgainzation,
        examName: examName ?? this.examName,
        postName: postName ?? this.postName,
        vacancyNumber: vacancyNumber ?? this.vacancyNumber,
        category: category ?? this.category,
        EligibilityCriteria: EligibilityCriteria ?? this.EligibilityCriteria,
        EducationQualification:
            EducationQualification ?? this.EducationQualification,
        ageLimit: ageLimit ?? this.ageLimit,
        selectionProcess: selectionProcess ?? this.selectionProcess,
        applicaitonMode: applicaitonMode ?? this.applicaitonMode,
        applicationDate: applicationDate ?? this.applicationDate,
        examDate: examDate ?? this.examDate,
        linkNoti: linkNoti ?? this.linkNoti,
        linkApplication: linkApplication ?? this.linkApplication,
        website: website ?? this.website,
        uid: uid ?? this.uid,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        isTripura: isTripura ?? this.isTripura,
        state: state ?? this.state,
        contactNo: contactNo ?? this.contactNo,
        contactName: contactName ?? this.contactName,
        jobLocation: jobLocation ?? this.jobLocation,
        searchData: searchData ?? this.searchData);
  }

  @override
  bool operator ==(covariant JobModel other) {
    if (identical(this, other)) return true;

    return other.jobName == jobName &&
        other.orgainzation == orgainzation &&
        other.examName == examName &&
        other.postName == postName &&
        other.vacancyNumber == vacancyNumber &&
        other.category == category &&
        other.EligibilityCriteria == EligibilityCriteria &&
        other.EducationQualification == EducationQualification &&
        other.ageLimit == ageLimit &&
        other.selectionProcess == selectionProcess &&
        other.applicaitonMode == applicaitonMode &&
        other.applicationDate == applicationDate &&
        other.examDate == examDate &&
        other.linkNoti == linkNoti &&
        other.linkApplication == linkApplication &&
        other.website == website &&
        other.uid == uid &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.isTripura == isTripura &&
        other.state == state &&
        other.contactNo == contactNo &&
        other.contactName == contactName &&
        other.jobLocation == jobLocation &&
        other.searchData == searchData;
  }

  @override
  int get hashCode {
    return jobName.hashCode ^
        orgainzation.hashCode ^
        examName.hashCode ^
        postName.hashCode ^
        vacancyNumber.hashCode ^
        category.hashCode ^
        EligibilityCriteria.hashCode ^
        EducationQualification.hashCode ^
        ageLimit.hashCode ^
        selectionProcess.hashCode ^
        applicaitonMode.hashCode ^
        applicationDate.hashCode ^
        examDate.hashCode ^
        linkNoti.hashCode ^
        linkApplication.hashCode ^
        website.hashCode ^
        uid.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        isTripura.hashCode ^
        state.hashCode ^
        contactNo.hashCode ^
        contactName.hashCode ^
        jobLocation.hashCode ^
        searchData.hashCode;
  }
}
