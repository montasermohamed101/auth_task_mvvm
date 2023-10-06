import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intern/UI/screens/auth/login/auth_states.dart';
import 'package:intern/UI/screens/auth/login/login_view_model.dart';
import 'package:intern/UI/utils/dialog_utils.dart';
import 'package:intern/UI/widgets/custom_text_form_field.dart';

import '../../home_screen.dart';

class Login extends StatelessWidget {
  static const String routeName = 'login';
  LoginViewModel viewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: viewModel,
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showLoading(context);
        } else if (state is AuthErrorState) {
          hideLoading(context);
          showErrorDialog(context, state.message);
        } else if (state is AuthSuccessState) {
          hideLoading(context);
          Navigator.pushNamed(context, HomeScreen.routeName);
        }
      },
      child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: viewModel.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 220,
                        margin: const EdgeInsets.all(16.0),
                      ),
                      Image.asset(
                        'assets/ic_top.png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 10,
                        child: Image.asset(
                          'assets/icon.png',
                        ),),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text("Log in to your account",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),

                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Text("Username", style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.grey,
                        )),
                        CustomTextFormField(
                          hintText: "Enter your username",
                          controller: viewModel.emailController,
                          validator: (text) {
                            if (text == null || text
                                .trim()
                                .isEmpty) {
                              return "Please enter a username";
                            }
                            return null;
                          },
                          type: TextInputType.text,
                          suffixIcon: IconButton(
                            onPressed: () {
                             viewModel.emailController.clear();
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Text("Password", style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.grey,
                        )),
                        BlocBuilder(
                          bloc: viewModel,
                          builder: (context, state) {
                            return CustomTextFormField(
                              hintText: "* * * * * * * * * * * * ",
                              controller: viewModel.passwordController,
                              validator: (text) {
                                if (text == null || text
                                    .trim()
                                    .isEmpty) {
                                  return "Please enter a username";
                                }
                                return null;
                              },
                              type: TextInputType.text,
                              obscureText: !viewModel.isVisible,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  viewModel.visibility();
                                },
                                icon: viewModel.isVisible
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (val) {
                                  val = false;
                                },
                              ),
                              const Text("Remember me",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700
                              ),
                              )
                            ],
                          ),
                          const Text("Forgot password?",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2.0,
                              decorationColor: Colors.blue,

                            ),

                          ),
                        ],
                      ),
                        const SizedBox(height: 20,),
                        MaterialButton(
                          color: Colors.blue,
                            textColor: Colors.white,
                            minWidth: double.infinity,
                            height: 44,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            onPressed: (){
                            viewModel.login();
                            }, child: const Text("Log In")),
                        const Row(
                          children: [
                            Text("Don't have an account?",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Text("Register",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2.0,
                                decorationColor: Colors.blue,

                              ),

                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          )


      ),
    );
  }
}
