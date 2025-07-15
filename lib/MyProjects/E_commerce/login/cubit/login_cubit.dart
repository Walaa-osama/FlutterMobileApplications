import 'package:bloc/bloc.dart';
import 'package:first_app/MyProjects/E_commerce/helpers/KApi.dart';
import 'package:first_app/MyProjects/E_commerce/helpers/dio_helpers.dart';
import 'package:first_app/MyProjects/E_commerce/helpers/hive_helpr.dart';
import 'package:first_app/MyProjects/E_commerce/login/model/login_model.dart';
import 'package:first_app/MyProjects/E_commerce/main/main_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  LoginModel loginModel = LoginModel();

  //--------- LOGIN -------------
  void login({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginLoadingState());
      final response = await DioHelpers.postData(
        path: KApi.login,
        body: {
          "email": email,
          "password": password,
        },
      );
      print(response.toString());
      loginModel = LoginModel.fromJson(response.data);
      print(loginModel.status);
      if (loginModel.status ?? false) {
        HiveHelper.setToken(loginModel.data?.token ?? "");
        Get.offAll(MainScreen());
        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState(loginModel.message ?? "Error"));
      }
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}
