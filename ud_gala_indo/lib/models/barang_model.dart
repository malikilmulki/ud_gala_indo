import 'package:json_annotation/json_annotation.dart';

part 'barang_model.g.dart';

@JsonSerializable()
class BarangModel {
  final String ? id;
  final String ? namaBarang;

  BarangModel({this.id, this.namaBarang});

  factory BarangModel.fromJson(Map<String, dynamic> json) =>
      _$BarangModelFromJson(json);
  Map<String, dynamic> toJson() => _$BarangModelToJson(this);
}