import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/modules/update_Screen/update_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppSuccessfulUpdateProfileState) {
          showToast(massage: 'Successfully Update', state: ToastStates.success);
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        nameController.text = cubit.profileModel!.data.name;
        emailController.text = cubit.profileModel!.data.email;
        phoneController.text = cubit.profileModel!.data.phone;
        bool isUpdate = false;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              defaultTextButton(
                  onPressed: () {
                    navigateTo(context, const UpdateScreen());
                  },
                  text: 'UPDATE'),
            ],
          ),
          body: ConditionalBuilder(
            condition: cubit.profileModel != null && token != null,
            builder: (context) => SingleChildScrollView(
                child: columnProfile(
                    cubit.profileModel!.data, context, state, isUpdate)),
            fallback: (context) => const LoginScreen(),
          ),
        );
      },
    );
  }
}
