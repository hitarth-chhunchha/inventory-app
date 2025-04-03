import 'package:app_links/app_links.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../constants/global.dart';
import '../../../constants/storage_keys.dart';
import '../../../core/model/utm_model.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AppLinks _appLinks = AppLinks();

  SplashBloc() : super(SplashInitial()) {
    on<StartSplash>(_onStartSplash);
    on<CheckAppLinks>(_onCheckAppLinks);
  }

  Future<void> _onStartSplash(
    StartSplash event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 3));
    add(CheckAppLinks());
  }

  /// Check for utm parameters
  Future<void> _onCheckAppLinks(
    CheckAppLinks event,
    Emitter<SplashState> emit,
  ) async {
    try {
      final Uri? uri = await _appLinks.getInitialLink();
      if (uri != null) {
        _handleIncomingLink(uri);
      }

      _appLinks.uriLinkStream.listen((Uri? uri) {
        if (uri != null) {
          _handleIncomingLink(uri);
        }
      });

      /// Check for login
      final box = await Hive.openBox(StorageKeys.loginBoxName);
      final bool isLoggedIn = box.get(
        StorageKeys.isLoggedInKey,
        defaultValue: false,
      );

      if (isLoggedIn) {
        emit(SplashNavigateToHome());
      } else {
        emit(SplashNavigateToLogin());
      }
    } catch (e) {
      debugPrint("ERROR -- _onCheckAppLinks: $e");
    }
  }

  void _handleIncomingLink(Uri uri) {
    final queryParams = uri.queryParameters;
    if (queryParams.isNotEmpty) {
      Global.utmData = UtmModel.fromJson(queryParams);
    }
  }
}
