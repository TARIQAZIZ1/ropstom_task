import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

import '../../data/repo/authentication_repo/authentication_repo.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  registerUser({required String userName, required String email, required String password}) async {
    emit(AuthenticationLoading());

    var response   = await AuthenticationRepo.registerUser(userName: userName, email: email, password: password);

    if(response == true){
      Fluttertoast.showToast(msg: 'Signup Successful');
      emit(AuthenticationLoaded());
    }else{
      emit(AuthenticationError());
    }
  }


  signInUser({ required String email, required String password}) async {
    emit(AuthenticationLoading());

    var response   = await AuthenticationRepo.logInUser( email: email, password: password);

    if(response == true){

      emit(AuthenticationLoaded());

    }else{
      emit(AuthenticationError());

    }
  }
}
