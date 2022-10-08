import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: ConditionalBuilder(
            condition: cubit.getCartModel != null &&
                cubit.getCartModel!.data!.cartItems!.isNotEmpty,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: cartColumn(cubit.getCartModel!, context),
            ),
            fallback: (context) => noItemFallBack(
                icon: Icons.mood_bad_outlined,
                text: 'No item in your cart,yet'),
          ),
        );
      },
    );
  }
}
