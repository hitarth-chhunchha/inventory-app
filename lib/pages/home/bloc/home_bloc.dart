import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_strings.dart';
import '../../../constants/global.dart';
import '../../../core/model/user_model.dart';
import '../../../core/widgets/snackbar_widget.dart';
import '../../../repository/user_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;
  static const int _pageSize = 20;

  HomeBloc({required this.userRepository})
    : super(HomeState(users: UserModel.dummyUserList())) {
    on<LoadUsers>(_onLoadUsers);
    on<RefreshUsers>(_onRefreshUsers);
    on<FilterUsers>(_onFilterUsers);
    on<UpdateRupee>(_onUpdateRupee);
  }

  Future<void> _onRefreshUsers(
    RefreshUsers event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        currentPage: 1,
        hasMore: true,
        users: UserModel.dummyUserList(),
      ),
    );

    add(LoadUsers());
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<HomeState> emit) async {
    if (!state.hasMore || state.isLoading) return;

    emit(state.copyWith(isLoading: true));

    await Future.delayed(const Duration(seconds: 1), () {
      final List<UserModel> newUsers = userRepository.fetchUsers(
        page: state.currentPage,
        pageSize: _pageSize,
      );
      emit(
        state.copyWith(
          users:
              state.currentPage == 1
                  ? []
                  : state.users, // clear list if current page 1
        ),
      );

      emit(
        state.copyWith(
          users: List.of(state.users)..addAll(newUsers),
          currentPage: state.currentPage + 1,
          hasMore: newUsers.length == _pageSize,
          isLoading: false,
        ),
      );
    });
  }

  Future<void> _onFilterUsers(
    FilterUsers event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final List<UserModel> filteredUsers = userRepository.filterUsers(
      event.query,
    );

    emit(
      state.copyWith(
        users: filteredUsers,
        currentPage: 1,
        hasMore: false,
        isLoading: false,
      ),
    );
  }

  void _onUpdateRupee(UpdateRupee event, Emitter<HomeState> emit) {
    if (event.newRupee < 0 || event.newRupee > 100) {
      showToast(
        Global.globalKey.currentContext!,
        AppStrings.enterRupeeBetween0To100,
        toastType: ToastType.failure,
      );
      return;
    }
    final List<UserModel> updatedUsers =
        state.users.map((user) {
          if (user.id == event.userId) {
            return user.copyWith(rupee: event.newRupee);
          }
          return user;
        }).toList();

    userRepository.updateUserRupee(event.userId, event.newRupee);

    emit(state.copyWith(users: updatedUsers));
  }
}
