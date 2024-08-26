import 'package:ud_gala_indo/features/incoming/domain/entities/outgoing.dart';

class OutgoingModel extends OutgoingEntity{
  final String ? id;
  final String ? barangId;
  final String ? namaBarang;
  final String ? karyawan;
  final String ? tanggalKeluar;
  final String ? beratCengkeh;

  OutgoingModel({
    this.id,
    this.barangId,
    this.namaBarang,
    this.karyawan,
    this.tanggalKeluar,
    this.beratCengkeh
  });

  factory OutgoingModel.fromJson(Map<String, dynamic> map){
    return OutgoingModel(
      id: map['id'],
      barangId: map['barangId'],
      namaBarang: map['namaBarang'],
      karyawan: map['karyawan'],
      tanggalKeluar: map['tanggalKeluar'],
      beratCengkeh: map['beratCengkeh']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'barangId': barangId,
      'namaBarang': namaBarang,
      'karyawan': karyawan,
      'tanggalKeluar': tanggalKeluar, // Convert DateTime to String
      'beratCengkeh': beratCengkeh
    };
  }
}