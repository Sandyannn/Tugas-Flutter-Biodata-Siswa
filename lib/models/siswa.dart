class SiswaModel {
  final int id;
  final String nis;
  final String nama;
  final String tpLahir;
  final String tgLahir;
  final String kelamin;
  final String agama;
  final String alamat;

  SiswaModel({
    required this.id,
    required this.nis,
    required this.nama,
    required this.tpLahir,
    required this.tgLahir,
    required this.kelamin,
    required this.agama,
    required this.alamat,
  });

  factory SiswaModel.fromJson(Map<String, dynamic> json) {
    return SiswaModel(
      id: json['id'],
      nis: json['nis'].toString(),
      nama: json['nama'],
      tpLahir: json['tp_lahir'],
      tgLahir: json['tg_lahir'],
      kelamin: json['kelamin'],
      agama: json['agama'],
      alamat: json['alamat'],
    );
  }

  Map<String, dynamic> toJson() => {
        'nis': nis,
        'nama': nama,
        'tp_lahir': tpLahir,
        'tg_lahir': tgLahir,
        'kelamin': kelamin,
        'agama': agama,
        'alamat': alamat,
      };
}