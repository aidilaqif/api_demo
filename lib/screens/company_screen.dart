import 'package:api_demo/screens/create_company.dart';
import 'package:api_demo/services/company_service.dart';
import 'package:flutter/material.dart';

import '../model/company.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
                context, MaterialPageRoute(builder: (_) => CreateCompany()));
            // If result is true, refresh the list
            if (result == true) {
              _refreshCompanies();
            }
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Company'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: CompanyService().getAllCompanies(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error receiving data from server'),
                );
              }

              if (snapshot.hasData) {
                List<Company> data = snapshot.data as List<Company>;
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Material(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            // height: MediaQuery.of(context).size.height*0.15,
                            width: double.maxFinite,
                            // color: Colors.red.shade100,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 15),
                              child: Row(
                                children: [
                                  // Logo
                                  Expanded(
                                    flex: 1,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          data[index].companyLogo!),
                                    ),
                                  ),
                                  // Company Details
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data[index].companyName!),
                                        Text(data[index].companyNumber!),
                                        Text(data[index].companyAddress!),
                                      ],
                                    ),
                                  ),
                                  // Action for company (edit or delete)
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        // Edit button
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          CreateCompany(
                                                            company:
                                                                data[index],
                                                          )));
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.blue,
                                            )),
                                        // Delete button
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Are you sure want to delete Company?"),
                                                      actions: [
                                                        ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              await CompanyService()
                                                                  .deleteCompany(
                                                                      data[index]
                                                                          .id!);
                                                              Navigator.pop(
                                                                  context);
                                                              _refreshCompanies();
                                                            },
                                                            child: Text("Yes")),
                                                        ElevatedButton(
                                                            onPressed: () {},
                                                            child: Text("NO"))
                                                      ],
                                                    );
                                                  });
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  void _refreshCompanies() {
    setState(() {}); // This will trigger the FutureBuilder to rebuild
  }
}
