import 'package:api_demo/services/employee_services.dart';
import 'package:flutter/material.dart';

import '../models/employee.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee Data"),
        actions: [
          IconButton(
            onPressed: (){
              print(EmployeeServices().getAllEmployeeData());
            },
            icon: const Icon(Icons.refresh)
          )
        ],
      ),
      body: FutureBuilder(
        // function that will return list of user
        future: EmployeeServices().getAllEmployeeData(),
        // function that will executed
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Center(
              child: Text('Error fetching employee Data'),
            );
          }

          if (snapshot.hasData){
            var data = snapshot.data as List<Employee>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data[index].avatar!),
                  ),
                  title: Text("${data[index].firstName} ${data[index].lastName}"),
                  subtitle: Text(data[index].email!),
                );
              }
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}