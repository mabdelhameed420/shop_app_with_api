import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/home.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSuccessfullyRegistrationState) {
          if (state.registrationModel!.status!) {
            showToast(
                massage: state.registrationModel!.message!,
                state: ToastStates.success);
            CachedHelper.putData(
                    key: 'token', value: state.registrationModel!.data!.token)
                .then((value) {
              token = state.registrationModel!.data!.token;
              navigateWithoutBack(context, const HomeScreen());
            });
          } else {
            showToast(
                massage: state.registrationModel!.message!,
                state: ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        var formKey = GlobalKey<FormState>();
        var emailController = TextEditingController();
        var nameController = TextEditingController();
        var phoneController = TextEditingController();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor('#FFFFFF'),
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: HexColor('#FFFFFF'),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                color: HexColor('#FFFFFF'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Superstore',
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          ?.copyWith(color: Colors.black),
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
                    SizedBox(
                      width: double.infinity,
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            defaultTextField(
                              prefixIcon: Icons.person,
                              context: context,
                              text: 'Name',
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'name is to short';
                                } else {
                                  return null;
                                }
                              },
                              isOutLineBorder: false,
                            ),
                            const SizedBox(height: 20),
                            defaultTextField(
                              prefixIcon: Icons.phone,
                              context: context,
                              text: 'Phone',
                              controller: phoneController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'email must be valid';
                                } else {
                                  return null;
                                }
                              },
                              type: TextInputType.phone,
                              isOutLineBorder: false,
                            ),
                            const SizedBox(height: 20),
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
                            const SizedBox(height: 20),
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
                              isPassword: AppCubit.get(context).isPassword,
                              suffix: AppCubit.get(context).suffixIcon,
                              suffixFunction: () {
                                AppCubit.get(context).pressSuffixButton();
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
                                  if (formKey.currentState!.validate()) {
                                    AppCubit.get(context).userRegistration(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        email: emailController.text,
                                        password: passwordController.text);
                                  } else {}
                                },
                                text: 'sign up',
                                isUpperCase: true,
                              ),
                              fallback: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              condition: state is! AppLoadingLoginState,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
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
                        const Text('I\' already exist?'),
                        defaultTextButton(
                            onPressed: () {
                              navigateTo(context, LoginScreen());
                            },
                            text: 'Sign in'),
                      ],
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
