import 'package:json_annotation/json_annotation.dart';
part 'utm_model.g.dart';

@JsonSerializable()
class UtmModel {
  @JsonKey(name: "utm_campaign")
  final String? utmCampaign;
  @JsonKey(name: "utm_source")
  final String? utmSource;
  @JsonKey(name: "utm_medium")
  final String? utmMedium;

  UtmModel({this.utmCampaign, this.utmSource, this.utmMedium});

  factory UtmModel.fromJson(Map<String, dynamic> json) =>
      _$UtmModelFromJson(json);

  Map<String, dynamic> toJson() => _$UtmModelToJson(this);

  @override
  String toString() {
    return 'UTM Campaign: $utmCampaign\nUTM Source: $utmSource\nUTM Medium: $utmMedium';
  }
}
