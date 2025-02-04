import 'package:ud_gala_indo/features/incoming/domain/entities/outgoing.dart';

class OutgoingModel extends OutgoingEntity{
  @override
  final String ? id;
  @override
  final String ? barangId;
  @override
  final String ? namaBarang;
  @override
  final String ? karyawan;
  @override
  final String ? tanggalKeluar;
  @override
  final String ? beratCengkeh;

  const OutgoingModel({
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