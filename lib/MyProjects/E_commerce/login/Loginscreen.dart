import 'package:first_app/Const.dart';
import 'package:first_app/MyProjects/E_commerce/login/cubit/login_cubit.dart';
import 'package:first_app/MyProjects/E_commerce/login/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final key = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          Get.snackbar(
            "Error",
            state.msg,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: 100.0,
            left: 20,
            right: 20,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: key,
                child: Column(
                  children: [
                    SizedBox(
                      width: width * .8,
                      child: Image.asset(
                        "${imagePath}logo2.png",
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: emailController,
                          height: height,
                          text: "Email",
                          //fun validator will pass it in the custom-text class
                          validator: (val) {
                            if (!val!.isEmail) {
                              return "this should be valid Email.";
                            } else if (val.length < 20) {
                              return " email should be more than 10 letters";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        CustomTextField(
                          height: height,
                          controller: passwordController,
                          text: "Password",
                          isPassword: true,
                          validator: (val) {
                            if (val!.length < 3) {
                              return "Password should be more than 3 letters";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return MaterialButton(
                                color: Colors.green,
                                minWidth: double.infinity,
                                child: loginWidget(state),
                                onPressed: () {
                                  if (key.currentState!.validate()) {
                                    context.read<LoginCubit>().login(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                  }
                                  print(" Email is ${emailController.text}");
                                  print(
                                      " Password is ${passwordController.text}");
                                });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginWidget(LoginState state) {
    if (state is LoginLoadingState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      "Login",
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }
}
