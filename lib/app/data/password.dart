import 'dart:convert';

Password passwordFromJson(String str) => Password.fromJson(json.decode(str));

class Password {
  Password({
    required this.results,
  });

  final Results results;

  factory Password.fromJson(Map<String, dynamic> json) => Password(
        results: Results.fromJson(json["results"]),
      );
}

class Results {
  Results({
    required this.password,
    required this.contains,
    required this.length,
    required this.id,
    required this.value,
  });

  final String password;
  final List<String> contains;
  final int length;
  final int id;
  final String value;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        password: json["password"],
        contains: List<String>.from(json["contains"].map((x) => x)),
        length: json["length"],
        id: json["id"],
        value: json["value"],
      );
}
