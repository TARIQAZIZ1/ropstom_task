part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}
class DashboardLoading extends DashboardState {}
class DashboardLoaded extends DashboardState {
  final List<DashboardModel> model;
  DashboardLoaded({required   this.model});
}
class DashboardNewAdded extends DashboardState {}
class DashboardError extends DashboardState {}
class DashboardUpdate extends DashboardState {
  final List<DashboardModel> model;
  DashboardUpdate({required   this.model});
}
class DashboardDeleted extends DashboardState {}
