import 'dart:math' show Random;

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../core/model/user_model.dart';

class UserRepository {
  static late Box<UserModel> userBox;

  UserRepository() {
    _initializeData();
  }

  void _initializeData() {
    if (userBox.isEmpty) {
      final random = Random();

      // Unique Indian names
      final List<String> indianNames = [
        'Aarav',
        'Vivaan',
        'Aditya',
        'Rohan',
        'Krishna',
        'Aryan',
        'Kabir',
        'Ishaan',
        'Dhruv',
        'Rahul',
        'Sneha',
        'Ananya',
        'Priya',
        'Meera',
        'Aditi',
        'Pooja',
        'Riya',
        'Tanya',
        'Neha',
        'Sanya',
        'Arjun',
        'Vikram',
        'Rishi',
        'Nikhil',
        'Siddharth',
        'Jay',
        'Harsh',
        'Yash',
        'Varun',
        'Raghav',
        'Karan',
        'Gaurav',
        'Mohit',
        'Tanmay',
        'Abhinav',
        'Saurabh',
        'Shubham',
        'Mayank',
        'Parth',
        'Ujjwal',
        'Rajat',
        'Himanshu',
        'Sameer',
      ];

      // List of Indian cities
      final indianCities = [
        'Mumbai',
        'Delhi',
        'Bangalore',
        'Hyderabad',
        'Chennai',
        'Kolkata',
        'Pune',
        'Jaipur',
        'Lucknow',
        'Ahmedabad',
      ];

      // Generate 43 users
      final users = List.generate(43, (index) {
        return UserModel(
          id: index + 1,
          name: indianNames[index],
          phone: '9${random.nextInt(1000000000).toString().padLeft(9, '0')}',
          city: indianCities[random.nextInt(indianCities.length)],
          imageUrl:
              'https://images.unsplash.com/photo-1740188305229-63c68ef04712?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fA%3D%3D',
          rupee: random.nextInt(101),
        );
      });

      userBox.addAll(users);
    }
  }

  List<UserModel> fetchUsers({required int page, int pageSize = 20}) {
    final int startIndex = (page - 1) * pageSize;
    final int endIndex = startIndex + pageSize;

    debugPrint("startIndex:$startIndex, endIndex:$endIndex");

    return userBox.values.toList().sublist(
      startIndex,
      endIndex > userBox.length ? userBox.length : endIndex,
    );
  }

  List<UserModel> filterUsers(String query) {
    return userBox.values
        .where(
          (user) =>
              user.name.toLowerCase().contains(query.toLowerCase()) ||
              user.phone.contains(query) ||
              user.city.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  void updateUserRupee(int userId, int newRupee) {
    final userKey = userBox.keys.firstWhere(
      (key) => userBox.get(key)?.id == userId,
      orElse: () => null,
    );

    if (userKey != null) {
      userBox.put(userKey, userBox.get(userKey)!.copyWith(rupee: newRupee));
    }
  }
}
