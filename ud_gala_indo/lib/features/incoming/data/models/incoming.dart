import 'package:ud_gala_indo/features/incoming/domain/entities/incoming.dart';

class IncomingModel extends IncomingEntity{
  final String ? id;
  final String ? barangId;
  final String ? namaBarang;
  final String ? petaniId;
  final String ? namaPetani;
  final String ? jenisKelamin;
  final String ? kawasanKebun;
  final String ? tanggalMasuk;
  final String ? beratCengkeh;
  final String ? status;

  IncomingModel({
    this.id,
    this.barangId,
    this.namaBarang,
    this.petaniId,
    this.namaPetani,
    this.jenisKelamin,
    this.kawasanKebun,
    this.tanggalMasuk,
    this.beratCengkeh,
    this.status
  });

  factory IncomingModel.fromJson(Map<String, dynamic> map){
      return IncomingModel(
        id: map['id'] ?? "",
        barangId: map['barangId'] ?? "",
        namaBarang: map['namaBarang'] ?? "",
        petaniId: map['petaniId'] ?? "",
        namaPetani: map['namaPetani'] ?? "",
        jenisKelamin: map['jenisKelamin'] ?? "",
        kawasanKebun: map['kawasanKebun'] ?? "",
        tanggalMasuk: map['tanggalMasuk'] ?? "",
        beratCengkeh: map['beratCengkeh'] ?? "",
        status: map['status'],
      );
  }
}