class Dasboardvalue {
  String? mesage;
  Datadasboardvalues? datadasboardvalues;

  Dasboardvalue({this.mesage, this.datadasboardvalues, this.eror});

  String? eror;
  factory Dasboardvalue.eror() {
    return Dasboardvalue(eror: "erordata");
  }

  factory Dasboardvalue.fromjson(Map<String, dynamic> json) {
    return Dasboardvalue(
        mesage: json["mesage"],
        datadasboardvalues: Datadasboardvalues.fromjson(json["data"]));
  }
}

class Datadasboardvalues {
  int? allbarang, alluser, barangterjualterkompir, barangterjualbelumdikompir;
  Datadasboardvalues(
      {this.allbarang,
      this.alluser,
      this.barangterjualterkompir,
      this.barangterjualbelumdikompir});

  factory Datadasboardvalues.fromjson(Map<String, dynamic> json) {
    return Datadasboardvalues(
        allbarang: json["allbarang"],
        alluser: json["alluser"],
        barangterjualterkompir: json["barangterjualterkompir"],
        barangterjualbelumdikompir: json["barangterjualbelumdikompir"]);
  }
}
