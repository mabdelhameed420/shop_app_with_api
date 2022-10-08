import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSuccessfulChangePasswordState) {
          if (state.changePassword.status!) {
            showToast(
                massage: state.changePassword.message!,
                state: ToastStates.success);
            navigateWithoutBack(context, const HomeScreen());
          } else {
            showToast(
                massage: state.changePassword.message!,
                state: ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var formKey = GlobalKey<FormState>();
        var oldPasswordController = TextEditingController();
        var newPasswordController = TextEditingController();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Change Password'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    defaultTextField(
                        context: context,
                        text: 'Old Password',
                        controller: oldPasswordController =
                            TextEditingController(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Old Password must be valid';
                          }
                          return null;
                        },
                        radius: 50,
                        isPassword: cubit.isPassword,
                        suffix: cubit.suffixIcon,
                        suffixFunction: () {
                          cubit.pressSuffixButton();
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextField(
                        context: context,
                        text: 'New Password',
                        controller: oldPasswordController =
                            TextEditingController(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'New Password must be valid';
                          }
                          return null;
                        },
                        radius: 50,),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.newPassword(
                                oldPassword: oldPasswordController.text,
                                newPassword: newPasswordController.text,
                                context: context);
                          }
                        },
                        text: 'change password',
                        isUpperCase: true,
                        radius: 30,)
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
