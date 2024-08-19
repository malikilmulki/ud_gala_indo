import "package:equatable/equatable.dart";

abstract class IncomingEntity extends Equatable {
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

  IncomingEntity({
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

  @override
  List<Object ? > get props{
    return [
      id,
      barangId,
      namaBarang,
      petaniId,
      namaPetani,
      jenisKelamin,
      kawasanKebun,
      tanggalMasuk,
      beratCengkeh,
      status
    ];
  }
}