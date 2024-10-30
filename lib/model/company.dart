// import 'package:flutter/material.dart';

class Company{

  int? id;
  String? companyLogo;
  String? companyName;
  String? companyNumber;
  String? companyAddress;

  Company({
    required this.id,
    required this.companyLogo,
    required this.companyName,
    required this.companyNumber,
    required this.companyAddress,
  });

  Company.fromJson(Map<String, dynamic> json){
    id = json['id'];
    companyLogo = json['logo'];
    companyName = json['name'];
    companyNumber = json['phone'];
    companyAddress = json['address'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {};

    data['id'] = id;
    data['logo'] = companyLogo;
    data['name'] = companyName;
    data['phone'] = companyNumber;
    data['address'] = companyAddress;

    return data;
  }
}