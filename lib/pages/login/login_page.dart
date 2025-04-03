import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_strings.dart';
import '../../constants/global.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/text_styles.dart';
import '../../core/utils/animation_util/custom_slide_animation.dart';
import '../../core/utils/app_validator.dart';
import '../../core/utils/loading_dialog.dart';
import '../../core/widgets/app_annotated_region.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/snackbar_widget.dart';
import '../../gen/assets.gen.dart';
import '../../routes/navigation_methods.dart';
import 'bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  final TextEditingController mobileTextController = TextEditingController();
  final FocusNode mobileNumberFocusNode = FocusNode();
  final TextEditingController passwordTextController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  Future<void> _onLogin(BuildContext context) async {
    if (_loginFormKey.currentState!.validate()) {
      context.showLoading();
      await Future.delayed(const Duration(seconds: 1), () {
        if (context.mounted) {
          context.read<LoginBloc>().add(
            LoginSubmitted(
              mobile: mobileTextController.text.trim(),
              password: passwordTextController.text.trim(),
            ),
          );
        }
      });

      context.hideLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppAnnotatedRegion(
      systemUiOverlayMode: SystemUiOverlayMode.dark,
      child: Scaffold(
        /// login button
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: AppButton(
            onPressed: () => _onLogin(context),
            buttonText: AppStrings.login,
          ),
        ),
        body: Stack(
          children: [
            /// Background image
            Assets.images.svg.loginHeader.svg(
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height / 2,
            ),

            SafeArea(
              minimum: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// title
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: Assets.images.png.logo.image(
                              fit: BoxFit.scaleDown,
                              height: 120,
                              width: 120,
                            ),
                          ),
                          Text(
                            AppStrings.login,
                            style: TextStyles.h4Medium.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          Text(
                            AppStrings.loginMsg,
                            style: TextStyles.h6Regular.copyWith(
                              color: AppColors.iconBg,
                            ),
                          ),
                        ],
                      ),
                    ),
                
                    /// login form
                    Flexible(
                      flex: 5,
                      child: BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state.status == LoginStatus.success) {
                            context.pushReplacementNamed(Routes.home);
                          } else if (state.status == LoginStatus.failure &&
                              state.errorMessage != null) {
                            showToast(
                              context,
                              state.errorMessage ?? "",
                              toastType: ToastType.failure,
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomSlideTransition(
                            animationType: AnimationType.leftToRight,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0, 0),
                                    spreadRadius: 1,
                                    blurRadius: 24,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsetsDirectional.symmetric(
                                vertical: 40,
                                horizontal: 16,
                              ),
                              margin: const EdgeInsetsDirectional.only(top: 40),
                              child: Form(
                                key: _loginFormKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  spacing: 16,
                                  children: [
                                    /// Mobile number
                                    AppTextField(
                                      textFieldType: TextFieldType.required,
                                      textEditingController: mobileTextController,
                                      focusNode: mobileNumberFocusNode,
                                      headerText: AppStrings.mobileNumber,
                                      labelText: AppStrings.enterMobileNumber,
                                      nextFocusNode: passwordFocusNode,
                                      inputFormat: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      textInputType: TextInputType.phone,
                                      prefixIcon: const Icon(Icons.phone),
                                      validator:
                                          (value) => AppValidator.mobileNumber(
                                            value: value ?? "",
                                          ),
                                    ),
                
                                    /// Password
                                    AppTextField(
                                      textFieldType: TextFieldType.required,
                                      textEditingController:
                                          passwordTextController,
                                      focusNode: passwordFocusNode,
                                      headerText: AppStrings.password,
                                      labelText: AppStrings.enterPassword,
                                      prefixIcon: const Icon(Icons.lock),
                                      textInputAction: TextInputAction.done,
                                      textCapitalization: TextCapitalization.none,
                                      obscureText: state.hidePassword,
                                      errorMaxLines: 6,
                                      suffixWidget: IconButton(
                                        onPressed: () {
                                          context.read<LoginBloc>().add(
                                            const TogglePasswordVisibility(),
                                          );
                                        },
                                        icon: Icon(
                                          state.hidePassword
                                              ? Icons.visibility_off_rounded
                                              : Icons.visibility_rounded,
                                        ),
                                      ),
                                      validator:
                                          (value) => AppValidator.password(
                                            value: value ?? "",
                                          ),
                                    ),
                
                                    if (Global.utmData != null)
                                      Text(Global.utmData!.toString()),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
