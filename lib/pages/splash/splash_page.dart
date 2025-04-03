import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../gen/assets.gen.dart';
import '../../routes/navigation_methods.dart';
import 'bloc/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigateToHome) {
          context.popAllAndPush(Routes.home);
        } else if (state is SplashNavigateToLogin) {
          context.popAllAndPush(Routes.login);
        }
      },
      child: Assets.images.png.splashImg.image(
        height: size.height,
        width: size.width,
        fit: BoxFit.fill,
      ),
    );
  }
}
