import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sales/domain/constents/app_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/remote/api_helper.dart';
import '../../../../data/remote/url_helper.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ApiHelper apiHelper;
  LoginBloc({required this.apiHelper}) : super(LoginInitialState()) {
    on<LoginUser>((event, emit) async{
      emit(LoginLoadingState());
      
      try{
        var data = await apiHelper.postApi(url: UrlHelper.Login_User_URL, mData: {
          "email":event.email,
          "password":event.pass
        }) as JsonResponse;

        if(data.status!){

          ///store user token in shared pref
          AppPref().setToken(data.token!);

          emit(LoginSuccessState());
        }



      } catch(e){
        emit(LoginFailedState(errorMsg: "Error: ${e.toString()}"));
      }
      
    });
  }
}
