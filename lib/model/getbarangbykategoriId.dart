class GetbarangbykategoriId {
  String? mesage;
  List<LisbarangbykategoriId>? databarang;
  GetbarangbykategoriId({this.mesage, this.databarang});
  factory GetbarangbykategoriId.fromjson(Map<String, dynamic> json) {
    return GetbarangbykategoriId(
        mesage: json["mesage"],
        databarang: List<LisbarangbykategoriId>.from(
            json["data"].map((x) => LisbarangbykategoriId.fromjson(x))));
  }
}

class LisbarangbykategoriId {
  int? id;
  String? namabarang;
  int? harga;
  String? no_plat;
  String? keterangan;
  String? thumnails;
  int? kategoribarangId;

  LisbarangbykategoriId(
      {this.id,
      this.namabarang,
      this.harga,
      this.no_plat,
      this.keterangan,
      this.thumnails,
      this.kategoribarangId});

  factory LisbarangbykategoriId.fromjson(Map<String, dynamic> json) {
    return LisbarangbykategoriId(
      id: json["id"],
      namabarang: json["namabarang"],
      harga: json["harga"],
      no_plat: json["no_plat"],
      keterangan: json["keterangan"],
      thumnails: json["thumnails"],
      kategoribarangId: json["kategoribarangId"],
    );
  }
}
