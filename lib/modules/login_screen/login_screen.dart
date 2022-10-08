import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/home.dart';
import 'package:shop_app/modules/registration/registration_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSuccessfullyLoginState) {
          if (state.loginModel!.status!) {
            showToast(
                massage: state.loginModel!.message!,
                state: ToastStates.success);
            CachedHelper.putData(
                    key: 'token', value: state.loginModel!.data!.token)
                .then((value) {
              token = state.loginModel!.data!.token;
              navigateWithoutBack(context, const HomeScreen());
            });
          } else {
            showToast(
                massage: state.loginModel!.message!, state: ToastStates.error);
          }
        }
        token = AppCubit().loginModel!.data!.token;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor('#040404'),
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarColor: HexColor('#040404'),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                width: double.infinity,
                color: HexColor('#040404'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Superstore',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'FASHION',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: HexColor('#FFFFFF'),
                          borderRadius: const BorderRadiusDirectional.only(
                            topEnd: Radius.circular(30),
                            topStart: Radius.circular(30),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: PhysicalModel(
                              color: HexColor('#FFFFFF'),
                              elevation: 10,
                              shadowColor: Colors.grey,
                              borderRadius: BorderRadius.circular(50),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Welcome',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        'Sign up to get started and experience great shopping deals',
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        'great shopping deals',
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      defaultTextField(
                                        prefixIcon: Icons.email_outlined,
                                        context: context,
                                        text: 'Email Address',
                                        controller: emailController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'email must be valid';
                                          } else {
                                            return null;
                                          }
                                        },
                                        type: TextInputType.emailAddress,
                                        isOutLineBorder: false,
                                      ),
                                      defaultTextField(
                                        prefixIcon: Icons.lock_outline,
                                        context: context,
                                        text: 'Password',
                                        controller: passwordController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'password is too short';
                                          } else {
                                            return null;
                                          }
                                        },
                                        type: TextInputType.visiblePassword,
                                        isOutLineBorder: false,
                                        isPassword:
                                            AppCubit.get(context).isPassword,
                                        suffix:
                                            AppCubit.get(context).suffixIcon,
                                        suffixFunction: () {
                                          AppCubit.get(context)
                                              .pressSuffixButton();
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ConditionalBuilder(
                                        builder: (context) => defaultButton(
                                          background: HexColor('FA4248'),
                                          radius: 30,
                                          function: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              AppCubit.get(context).userLogin(
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text);
                                            } else {}
                                          },
                                          text: 'sign in',
                                          isUpperCase: true,
                                        ),
                                        fallback: (context) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        condition:
                                            state is! AppLoadingLoginState,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsetsDirectional.all(20),
                            child: Column(
                              children: [
                                const Text(
                                  '-OR-',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                makeButton(
                                    icon: Icons.facebook_outlined,
                                    text: 'Si'
                                        'gn In with Facebook',
                                    onTab: () {}),
                                const SizedBox(
                                  height: 10,
                                ),
                                makeButton(
                                    icon: Icons.g_mobiledata_sharp,
                                    text: 'Sign In with Google',
                                    onTab: () {}),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Don\'t have an account?'),
                                    defaultTextButton(
                                        onPressed: () {
                                          navigateTo(context,
                                              const RegistrationScreen());
                                        },
                                        text: 'Signup'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
