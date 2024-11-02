import 'package:flutter/material.dart';

import '../model/company.dart';
import '../services/company_service.dart';

class CreateCompany extends StatefulWidget {
  final Company? company;
  const CreateCompany({super.key, this.company});

  @override
  State<CreateCompany> createState() => _CreateCompanyState();
}

class _CreateCompanyState extends State<CreateCompany> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    if (widget.company != null) {
      _nameController.text = widget.company!.companyName!;
      _addressController.text = widget.company!.companyAddress!;
      _phoneController.text = widget.company!.companyNumber!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Company'),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Name form
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.length == 0) {
                      return "Please enter company name.";
                    }
                  },
                  controller: _nameController,
                  decoration: InputDecoration(
                      helperText: "Your name here",
                      labelText: "Name",
                      hintText: "Enter the company name",
                      border: OutlineInputBorder()),
                ),
              ),
              // Address Form
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      helperText: "Your address here",
                      labelText: "Address",
                      hintText: "Enter the company address",
                      border: OutlineInputBorder()),
                ),
              ),
              // Phone Form
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                      helperText: "Your company phone number here",
                      labelText: "Phone Number",
                      hintText: "Enter the company phone number",
                      border: OutlineInputBorder()),
                ),
              ),
              // Submit Button
              ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      Company newCompany = Company(
                        companyName: _nameController.text,
                        companyAddress: _addressController.text,
                        companyNumber: _phoneController.text,
                        companyLogo: "https://logo.clearbit.com/utexas.edu",
                        // id: null,
                      );
                      if (widget.company != null) {
                        await CompanyService()
                            .updateCompany(newCompany, widget.company!.id!);
                      } else {
                        await CompanyService().createCompany(newCompany);
                      }

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Company added successfully")));
                      // Return true to indicate that a refresh is needed
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text(widget.company == null
                      ? "Create Company"
                      : "Update Company"))
            ],
          ),
        ),
      ),
    );
  }
}
