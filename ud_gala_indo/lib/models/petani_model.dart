import 'package:json_annotation/json_annotation.dart';

part 'petani_model.g.dart';

@JsonSerializable()
class PetaniModel {
  final String ? id;
  final String ? namaPetani;
  final String ? jenisKelamin;

  PetaniModel({this.id, this.namaPetani, this.jenisKelamin});

  factory PetaniModel.fromJson(Map<String, dynamic> json) =>
      _$PetaniModelFromJson(json);
  Map<String, dynamic> toJson() => _$PetaniModelToJson(this);
}