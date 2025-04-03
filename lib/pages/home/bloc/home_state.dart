part of 'home_bloc.dart';

class HomeState extends Equatable {
  final List<UserModel> users;
  final int currentPage;
  final bool hasMore;
  final bool isLoading;

  const HomeState({
    this.users = const [],
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoading = false,
  });

  HomeState copyWith({
    List<UserModel>? users,
    int? currentPage,
    bool? hasMore,
    bool? isLoading,
  }) {
    return HomeState(
      users: users ?? this.users,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [users, currentPage, hasMore, isLoading];
}
