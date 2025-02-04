import "package:equatable/equatable.dart";

abstract class OutgoingEntity extends Equatable {
  final String ? id;
  final String ? barangId;
  final String ? namaBarang;
  final String ? karyawan;
  final String ? tanggalKeluar;
  final String ? beratCengkeh;

  const OutgoingEntity({
    this.id,
    this.barangId,
    this.namaBarang,
    this.karyawan,
    this.tanggalKeluar,
    this.beratCengkeh
  });

  @override
  List<Object ? > get props{
    return [
      id,
      barangId,
      namaBarang,
      karyawan,
      tanggalKeluar,
      beratCengkeh
    ];
  }
}