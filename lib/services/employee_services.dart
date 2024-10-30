import 'dart:convert';

import 'package:api_demo/models/employee.dart';
import 'package:http/http.dart' as http;

class EmployeeServices {
  String baseUrl = "https://reqres.in/api/"; // baseUrl is the same for 1 api

  getAllEmployeeData()async{
    // empty list
    List<Employee> allEmployees = [];
    try {
      var response = await http.get(Uri.parse(baseUrl + "users?page=2"));
      if(response.statusCode==200){
        var data = response.body;
        var decodedData = jsonDecode(data); // to decode json data
        var employees = decodedData['data'];

        // print(employees);

        for(var employee in employees){
          //create new object for employee class
          Employee newEmployee = Employee.fromJson(employee);
          allEmployees.add(newEmployee);
        }

        print(allEmployees);
        return allEmployees;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}