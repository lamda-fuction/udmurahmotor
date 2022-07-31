class Search {
  String? mesage;
  List<Datasearch>? datasearch;
  Search({this.mesage, this.datasearch});
  factory Search.fromjson(Map<String, dynamic> json) {
    return Search(
        mesage: json["mesage"],
        datasearch: List<Datasearch>.from(
            json["data"].map((x) => Datasearch.fromjson(x))));
  }
}

class Datasearch {
  int? id;
  String? namabarang;
  int? harga;
  String? keterangan;
  String? thumnails;
  Datasearch(
      {this.id, this.namabarang, this.harga, this.thumnails, this.keterangan});
  factory Datasearch.fromjson(Map<String, dynamic> json) {
    return Datasearch(
        id: json["id"],
        namabarang: json["namabarang"],
        harga: json["harga"],
        keterangan: json["keterangan"],
        thumnails: json["thumnails"]);
  }
}
