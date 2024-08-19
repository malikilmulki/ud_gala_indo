import 'package:ud_gala_indo/features/incoming/domain/entities/incoming.dart';
import 'package:ud_gala_indo/features/incoming/domain/entities/outgoing.dart';

class OutgoingModel extends OutgoingEntity{
  final String ? id;
  final String ? barangId;
  final String ? namaBarang;
  final String ? petaniId;
  final String ? namaPetani;
  final String ? tanggalKeluar;
  final String ? beratCengkeh;
  final String ? status;

  OutgoingModel({
    this.id,
    this.barangId,
    this.namaBarang,
    this.petaniId,
    this.namaPetani,
    this.tanggalKeluar,
    this.beratCengkeh,
    this.status
  });

  factory OutgoingModel.fromJson(Map<String, dynamic> map){
    return OutgoingModel(
      id: map['id'],
      barangId: map['barangId'],
      namaBarang: map['namaBarang'],
      petaniId: map['petaniId'],
      namaPetani: map['namaPetani'],
      tanggalKeluar: map['tanggalKeluar'],
      beratCengkeh: map['beratCengkeh'],
      status: map['status']
    );
  }
}