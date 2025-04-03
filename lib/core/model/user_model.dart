import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phone;

  @HiveField(2)
  final String city;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final int rupee;

  @HiveField(5)
  final int id;

  bool get isHigh => rupee > 50;

  UserModel({
    required this.name,
    required this.phone,
    required this.city,
    required this.imageUrl,
    required this.rupee,
    required this.id,
  });

  UserModel copyWith({
    String? name,
    String? phone,
    String? city,
    String? imageUrl,
    int? rupee,
    int? id,
  }) {
    return UserModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      imageUrl: imageUrl ?? this.imageUrl,
      rupee: rupee ?? this.rupee,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [name, phone, city, imageUrl, rupee, id];

  static List<UserModel> dummyUserList() {
    return List.generate(
      5,
      (index) => UserModel(
        name: "name",
        phone: "phone",
        city: "city",
        imageUrl: "",
        rupee: 0,
        id: 0,
      ),
    );
  }
}
