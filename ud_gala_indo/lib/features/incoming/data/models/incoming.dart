import 'package:ud_gala_indo/features/incoming/domain/entities/incoming.dart';

class IncomingModel extends IncomingEntity{
  @override
  final String ? id;
  @override
  final String ? no;
  @override
  final String ? barangId;
  @override
  final String ? namaBarang;
  @override
  final String ? petaniId;
  @override
  final String ? namaPetani;
  @override
  final String ? jenisKelamin;
  @override
  final String ? kawasanKebun;
  @override
  final String ? tanggalMasuk;
  @override
  final String ? beratCengkeh;
  @override
  final String ? status;

  const IncomingModel({
    this.id,
    this.no,
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
        no: map['no'] ?? "",
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

  factory IncomingModel.fromEntity(IncomingEntity entity) {
    return IncomingModel(
      id: entity.id,
      no: entity.no,
      barangId: entity.barangId,
      namaBarang: entity.namaBarang,
      petaniId: entity.petaniId,
      namaPetani: entity.namaPetani,
      jenisKelamin: entity.jenisKelamin,
      kawasanKebun: entity.kawasanKebun,
      tanggalMasuk: entity.tanggalMasuk,
      beratCengkeh: entity.beratCengkeh,
      status: entity.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'barangId': barangId,
      'namaBarang': namaBarang,
      'petaniId': petaniId,
      'namaPetani': namaPetani,
      'jenisKelamin': jenisKelamin,
      'kawasanKebun': kawasanKebun,
      'tanggalMasuk': tanggalMasuk, // Convert DateTime to String
      'beratCengkeh': beratCengkeh,
      'status': status,
    };
  }
}