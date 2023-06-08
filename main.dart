import 'package:project/models/company_positions.dart';
import 'package:project/models/position.dart';
import 'package:project/service/http/analytics.dart';

void main() async {
  List<CompanyPositions> companies = [];
  await companyPositions().then((value) {
    companies.addAll(value);
  });

  for (CompanyPositions company in companies) {
    print('COMPANY');
    print(company.company);
    for (Position position in company.positions) {
      print(position.position);
      print(position.count);
    }
  }
}
