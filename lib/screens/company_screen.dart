import 'package:api_demo/services/company_service.dart';
import 'package:flutter/material.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Company'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: CompanyService().getAllCompanies(),
        builder: (context, snapshot){

          if(snapshot.hasError){
            return const Center(
              child: Text('Error receiving data from server'),
            );
          }

          if(snapshot.hasData){
            return ListView.builder(
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: 300,
                  ),
                );
              }
            );
          }else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      )
    );
  }
}