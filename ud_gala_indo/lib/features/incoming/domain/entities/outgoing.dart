import "package:equatable/equatable.dart";

abstract class OutgoingEntity extends Equatable {
  final String ? id;
  final String ? barangId;
  final String ? namaBarang;
  final String ? petaniId;
  final String ? namaPetani;
  final String ? tanggalKeluar;
  final String ? beratCengkeh;
  final String ? status;

  OutgoingEntity({
    this.id,
    this.barangId,
    this.namaBarang,
    this.petaniId,
    this.namaPetani,
    this.tanggalKeluar,
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
      tanggalKeluar,
      beratCengkeh,
      status
    ];
  }
}