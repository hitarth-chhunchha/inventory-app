import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../constants/app_strings.dart';
import '../../constants/storage_keys.dart';
import '../../core/model/user_model.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/text_styles.dart';
import '../../core/utils/dialog_utils.dart';
import '../../core/widgets/app_empty_widget.dart';
import '../../core/widgets/app_text_field.dart';
import '../../gen/assets.gen.dart';
import '../../routes/navigation_methods.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  void _onSearchChanged({required BuildContext context}) {
    context.read<HomeBloc>().add(FilterUsers(_searchController.text.trim()));
  }

  Future<bool> _onLogout() async {
    final box = await Hive.openBox(StorageKeys.loginBoxName);
    await box.put(StorageKeys.isLoggedInKey, false);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.userList),
        actions: [
          /// logout
          IconButton(
            onPressed: () async {
              if (await _onLogout() && context.mounted) {
                context.popAllAndPush(Routes.login);
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          /// search field
          Padding(
            padding: const EdgeInsets.all(10),
            child: AppTextField(
              textEditingController: _searchController,
              focusNode: _searchFocusNode,
              labelText: AppStrings.searchBy,
              suffixWidget: const Icon(Icons.search),
              textInputAction: TextInputAction.done,
              onChanged: (_) => _onSearchChanged(context: context),
            ),
          ),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (blocContext, state) {
                return RefreshIndicator.adaptive(
                  onRefresh: () async {
                    context.read<HomeBloc>().add(RefreshUsers());
                    _searchController.text = "";
                  },
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if ((notification.metrics.pixels >=
                              notification.metrics.maxScrollExtent - 50) &&
                          notification.metrics.axis == Axis.vertical) {
                        context.read<HomeBloc>().add(LoadUsers());
                      }
                      return false;
                    },
                    child: Skeletonizer(
                      enabled: state.isLoading && state.currentPage == 1,
                      child: Visibility(
                        visible: state.users.isNotEmpty,
                        replacement: AppEmptyWidget(
                          imgPath: Assets.images.svg.noData.path,
                          title: AppStrings.noDataFound,
                          subtitle: "",
                        ),
                        child: ListView.builder(
                          itemCount: state.users.length,
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return ListTile(
                              onTap: () => _showRupeeDialog(blocContext, user),
                              leading: Skeleton.replace(
                                replacement: const Bone.circle(size: 48),
                                child: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                    user.imageUrl,
                                  ),
                                ),
                              ),
                              title: Text("${user.id}: ${user.name}"),

                              subtitle: Text("${user.phone} - ${user.city}"),

                              // price
                              trailing: Text(
                                "${user.rupee} ₹",
                                style: TextStyles.body2Medium.copyWith(
                                  color:
                                      user.isHigh
                                          ? AppColors.success
                                          : AppColors.red,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// loader
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Visibility(
                visible: state.isLoading && state.currentPage > 1,
                child: _bottomLoader(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _bottomLoader() {
    return const Center(
      child: Padding(
        padding: EdgeInsetsDirectional.only(bottom: 40),
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator.adaptive(
            backgroundColor: AppColors.primary,
          ),
        ),
      ),
    );
  }

  void _showRupeeDialog(BuildContext blocContext, UserModel user) {
    final TextEditingController rupeeController = TextEditingController(
      text: user.rupee.toString(),
    );
    final FocusNode rupeeFocusNode = FocusNode();

    DialogUtils.showAppDialog(
      context: blocContext,
      title: AppStrings.updateRupee,
      customWidget: AppTextField(
        textEditingController: rupeeController,
        focusNode: rupeeFocusNode,
        inputFormat: [FilteringTextInputFormatter.digitsOnly],
        textInputType: TextInputType.number,
        labelText: AppStrings.enterNewRupee,
        headerText: AppStrings.enterNewRupee,
        maxLength: 3,
        counterText: "",
        textInputAction: TextInputAction.done,
      ),
      negativeText: AppStrings.cancel,
      onNegativeTap: () {
        blocContext.pop();
      },
      positiveText: AppStrings.update,
      onPositiveTap: () {
        final newRupee = int.tryParse(rupeeController.text) ?? user.rupee;
        blocContext.read<HomeBloc>().add(
          UpdateRupee(userId: user.id, newRupee: newRupee),
        );

        blocContext.pop();
      },
      closeDialogOnBtnClick: false,
    );
  }
}
