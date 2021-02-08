import 'package:flutter_test/flutter_test.dart';
import 'package:priscilla_abhulimen/models/carOwnerModel.dart';
import 'package:priscilla_abhulimen/services/filter_services.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('List should be filtered', () async{
    int startYear = 1990;
    int endYear = 2009;
    String gender = '';
    List<String> countries = ["United States", "Wakanda"];
    List<String> colors = [];
    List<CarOwner> carOwner = [];
    carOwner = await getFilteredCarOwners(startYear, endYear, gender, countries, colors);

    expect(carOwner, []);
  });
}