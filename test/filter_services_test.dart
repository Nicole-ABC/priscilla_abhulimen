import 'package:flutter_test/flutter_test.dart';
import 'package:priscilla_abhulimen/models/car_owner_model.dart';
import 'package:priscilla_abhulimen/services/filter_services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('List should be filtered with no data results', () async{
    int startYear = 1990;
    int endYear = 2009;
    String gender = '';
    List<String> countries = ["United States", "Wakanda"];
    List<String> colors = [];
    List<CarOwner> carOwner = [];

    carOwner = await getFilteredCarOwners(startYear, endYear, gender, countries, colors);

    expect(carOwner.length, 0);
  });

  test('List should be filtered with data results', () async{
    int startYear = 1990;
    int endYear = 2005;
    String gender = "female";
    List<String> countries = ["Indonesia", "Peru", "Russia", "China" ];
    List<String> colors = ["Fuscia", "Goldenrod", "Violet", "Teal"];
    List<CarOwner> carOwner = [];

    carOwner = await getFilteredCarOwners(startYear, endYear, gender, countries, colors);

    expect(carOwner.length, 1399);
  });
}