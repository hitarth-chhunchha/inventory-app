import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'constants/storage_keys.dart';
import 'core/model/user_model.dart';
import 'repository/user_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.init((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(UserModelAdapter());
  UserRepository.userBox = await Hive.openBox<UserModel>(
    StorageKeys.userBoxName,
  );

  runApp(const MyApp());
}
