import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../model/company.dart';

class CompanyService {
  String baseUrl = "https://retoolapi.dev/y4lflW/";

  getAllCompanies() async {
    try {
      List<Company> allCompanies = [];
      var response = await http.get(Uri.parse(baseUrl + 'company'));

      if (response.statusCode == 200) {
        var data = response.body;

        var jsonData = jsonDecode(data);

        print(jsonData);

        for (var company in jsonData) {
          Company newCompany = Company.fromJson(company);
          allCompanies.add(newCompany);
        }
        return allCompanies;
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured: ${e}");
    }
  }

  createCompany(Company company) async {
    log("create company is called");
    try {
      var response = await http.post(
        Uri.parse(baseUrl + 'company'),
        body: company.toJson(),
      );

      log("respone is ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        print(
            "The company is successfully created with the following details: ${response.body}");
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured: ${e}");
    }
  }

  updateCompany(Company company, int id) async {
    try {
      var response = await http.put(
        Uri.parse(baseUrl + "company" + "/$id"),
        body: company.toJson(),
      );
      // log("the response status code is ${response.statusCode}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        print("The company ");
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured: ${e}");
    }
  }

  deleteCompany(int id) async {
    try {
      var response = await http.delete(Uri.parse(baseUrl + "company" + "/$id"));

      if (response.statusCode == 204 || response.statusCode == 200) {
        print(
            "The company is successfully deleted with the following details: ${response.body}");
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured: ${e}");
    }
  }
}
