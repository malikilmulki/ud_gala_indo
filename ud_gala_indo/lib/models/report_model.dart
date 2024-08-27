import 'package:json_annotation/json_annotation.dart';

part 'report_model.g.dart';

@JsonSerializable()
class ReportModel {
  final String ? bulan;
  final String ? jumlah;
  final String ? berat;

  ReportModel({this.bulan, this.jumlah, this.berat});

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReportModelToJson(this);
}