class Bayarwithmitranst {
  Datataobjek? data;
  Bayarwithmitranst({this.data});
  factory Bayarwithmitranst.frojson(Map<String, dynamic> json) =>
      Bayarwithmitranst(data: Datataobjek.fromjson(json["data"]));
}

class Datataobjek {
  String? permata_va_number;
  String? gross_amount;
  List<Va_number>? va_number;
  Datataobjek({this.va_number, this.gross_amount});
  factory Datataobjek.fromjson(Map<String, dynamic> json) => Datataobjek(
      gross_amount: json["gross_amount"],
      va_number: List<Va_number>.from(
          json["va_numbers"].map((x) => Va_number.fromjson(x))));
}

class Va_number {
  String? bank;
  String? va_numbers;

  Va_number({this.bank, this.va_numbers});

  factory Va_number.fromjson(Map<String, dynamic> json) {
    return Va_number(bank: json["bank"], va_numbers: json["va_number"]);
  }
}
