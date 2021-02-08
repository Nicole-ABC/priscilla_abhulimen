// To parse this JSON data, do
//
//     final filter = filterFromJson(jsonString);


List<Filter> filterFromJson(var str) =>
    List<Filter>.from(str.map((x) => Filter.fromJson(x)));



class Filter {
  Filter({
    this.id,
    this.startYear,
    this.endYear,
    this.gender,
    this.countries,
    this.colors,
  });

  int id;
  int startYear;
  int endYear;
  String gender;
  List<String> countries;
  List<String> colors;


  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        id: json["id"],
        startYear: json["start_year"],
        endYear: json["end_year"],
        gender: json["gender"],
        countries: List<String>.from(json["countries"].map((x) => x)),
        colors: List<String>.from(json["colors"].map((x) => x)),
      );

}
