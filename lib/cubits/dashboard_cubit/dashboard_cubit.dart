import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ropstom_task/data/models/dashboard_model/dashboard_model.dart';
import 'package:ropstom_task/data/repo/dashboard_repo/dashboard_repo.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

 ///function for adding new user
  addNewEntry({required DashboardModel model}) async {
    ///first emit loading state
    emit(DashboardLoading());
    ///calling add new function inrepository
    var data = await DashboardRepo.addNewEntry(model: model);
    if(data == true){
      ///if repo returns true then loaded state will be emitted
      emit(DashboardNewAdded());
    }else{
      ///else error state will be emitted
      emit(DashboardError());

    }
  }

///function for showing data
  fetchData() async {
    ///first emit loading state
    emit(DashboardLoading());
    ///calling add new function in repository
    var data = await DashboardRepo.fetchRecord();
    if(data != null){
      ///if repo returns true then loaded state will be emitted and data will be send in state
      emit(DashboardLoaded(model: data));
    }else{
      ///else error state will be emitted
      emit( DashboardError());
    }



  }

///function for deleting data
  deleteRecord({required int id})async{
    var data = await DashboardRepo.deleteRecord(id: id);
    if(data == true){
      emit(DashboardDeleted());
    }else{
      emit(DashboardError());

    }
  }

///function for updating data
  updateRecord({required DashboardModel model}) async {
   var data = await  DashboardRepo.updateRecord(model: model);
   if(data != null){
     emit(DashboardUpdate(model: data));
   }else{
     emit(DashboardError());
   }
  }
}



