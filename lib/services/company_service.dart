import 'package:http/http.dart' as http;
class CompanyService{

  String baseUrl = "https://retoolapi.dev/y4lflW/";

  getAllCompanies() async {
    try {
      var response = await http.get(Uri.parse(baseUrl+'company'));

      if(response.statusCode == 200){
        var data = response.body;
      }else{
        throw Exception("Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured: ${e}");
    }
  }

  createCompany() async {
    try {
      
    } catch (e) {
      print("Error occured: ${e}");
    }

  }

  updateCompany() async {
    try {
      
    } catch (e) {
      print("Error occured: ${e}");
    }
  }

  deleteCompany() async {
    try {
      
    } catch (e) {
      print("Error occured: ${e}");
    }
  }
}