import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/home.dart';
import 'package:shop_app/models/cart_model/cart_model.dart';
import 'package:shop_app/models/get_categories_model/get_categories_model.dart';
import 'package:shop_app/models/home_data_model/home_data_model.dart';
import 'package:shop_app/modules/change_password/change_password.dart';
import 'package:shop_app/modules/product_in_Screen/product_in_screen.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/cubit/app_states.dart';

import '../../models/profile_model/profile_model.dart';
import '../cubit/app_cubit.dart';
import '../style/color.dart';

Widget defaultButton({
  double width = double.infinity,
  Color? background,
  bool isUpperCase = true,
  double radius = 0,
  required function,
  required String text,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        color: background ?? Colors.red,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextField({
  required context,
  TextInputType type = TextInputType.text,
  IconData? prefixIcon,
  required String text,
  required TextEditingController controller,
  required FormFieldValidator<String>? validator,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  bool isOutLineBorder = true,
  bool isPassword = false,
  IconData? suffix,
  int? maxLength,
  VoidCallback? suffixFunction,
  int radius = 0,
  GestureTapCallback? onTap,
  FontWeight? fontInWeight,
  double? fontInSize,
  bool readOnly = false,
}) =>
    TextFormField(
      readOnly: readOnly,
      controller: controller,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      keyboardType: type,
      obscureText: isPassword,
      validator: validator,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: text,
        border: isOutLineBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius.roundToDouble()))
            : null,
        prefixIcon: Icon(prefixIcon, size: 24),
        suffix: suffix != null
            ? IconButton(
                onPressed: suffixFunction,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
      ),
      onTap: onTap,
      style: TextStyle(
        color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
        fontWeight: fontInWeight,
        fontSize: fontInSize,
      ),
    );

Widget divider() => Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        height: 1,
        color: Colors.grey,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateWithoutBack(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

Widget defaultIconButton(
        {required VoidCallback onPressed,
        required IconData icon,
        Color? iconColor}) =>
    IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: iconColor),
    );

Widget makeButton(
        {double padding = 15,
        double radius = 30,
        dynamic color = Colors.grey,
        required IconData icon,
        required String text,
        required VoidCallback onTab}) =>
    InkWell(
      onTap: onTab,
      child: Container(
        padding: EdgeInsetsDirectional.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(radius),
          border: BorderDirectional(
            top: BorderSide(color: color, width: 1),
            bottom: BorderSide(color: color, width: 1),
            start: BorderSide(color: color, width: 1),
            end: BorderSide(color: color, width: 1),
          ),
        ),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 50,
            ),
            Text(text),
          ],
        ),
      ),
    );

Widget defaultTextButton(
        {required VoidCallback onPressed,
        required String text,
        Color? color}) =>
    TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: color),
        ));

void showToast({
  required String massage,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: massage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 14.0);
}

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
    case ToastStates.error:
      color = Colors.grey;
      break;
  }
  return color;
}

Widget productsItem(
        HomeModel homeModel, CategoryModel categoryModel, context) =>
    SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            items: homeModel.data.banners
                .map(
                  (e) => Image(
                    image: NetworkImage('${e.image}'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 200,
              initialPage: 0,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1.0,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          categoryItem(categoryModel.data.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                      itemCount: categoryModel.data.data.length),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.grey[200],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.67,
              crossAxisCount: 2,
              children: List.generate(
                homeModel.data.products.length,
                (index) =>
                    buildGridProduct(homeModel.data.products[index], context),
              ),
            ),
          ),
        ],
      ),
    );

Widget buildGridProduct(ProductsModel model, context) => InkWell(
      onTap: () {
        index = AppCubit.get(context)
            .homeModel!
            .data
            .products
            .indexWhere(((element) => element.id == model.id));
        inFavorites =
            AppCubit.get(context).homeModel!.data.products[index].inFavorites!;
        inCart = AppCubit.get(context).homeModel!.data.products[index].inCart!;
        navigateTo(context, const ProductInScreen());
      },
      child: Container(
        color: HexColor('#FFFFFF'),
        child: Column(
          children: [
            Stack(alignment: AlignmentDirectional.bottomStart, children: [
              Image(
                image: NetworkImage(
                  model.image!,
                ),
                height: 200,
                width: double.infinity,
              ),
              if (model.discount != 0)
                PhysicalModel(
                  color: defaultColor,
                  elevation: 5,
                  shadowColor: Colors.grey,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price?.round()}',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice?.round()}',
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor:
                            AppCubit.get(context).favorites[model.id]!
                                ? defaultColor
                                : Colors.grey,
                        child: IconButton(
                            onPressed: () {
                              AppCubit.get(context).changeFavorites(model.id);
                              inFavorites = AppCubit.get(context)
                                  .homeModel!
                                  .data
                                  .products[index]
                                  .inFavorites!;
                            },
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget categoryItem(DataModel model) => SizedBox(
      height: 120,
      width: 120,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 120,
            width: 120,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            width: double.infinity,
            color: Colors.black.withOpacity(.60),
            child: Text(
              model.name,
              style: const TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

Widget categoryBuild(DataModel model) => Row(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Image(
            image: NetworkImage(model.image),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          model.name,
        ),
        const Spacer(),
        defaultIconButton(
            onPressed: () {}, icon: Icons.arrow_forward_ios_outlined),
      ],
    );

Widget listProduct(model, context, {bool isSearch = false}) => InkWell(
      onTap: () {
        index = isSearch
            ? AppCubit.get(context)
                .searchModel!
                .data!
                .data!
                .indexWhere(((element) => element.id == model.id))
            : AppCubit.get(context)
                .getFavoritesModel!
                .data!
                .data!
                .indexWhere(((element) => element.product!.id == model.id));
        inFavorites =
            AppCubit.get(context).homeModel!.data.products[index].inFavorites!;
        inCart = AppCubit.get(context).homeModel!.data.products[index].inCart!;
        navigateTo(context, const ProductInScreen());
      },
      child: SizedBox(
        width: double.infinity,
        height: 120,
        child: Row(
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child:
                  Stack(alignment: AlignmentDirectional.bottomStart, children: [
                Image(
                  image: NetworkImage(
                    model.image!,
                  ),
                  height: 120,
                  width: 120,
                ),
                if (model.discount != 0 && !isSearch)
                  PhysicalModel(
                    color: defaultColor,
                    shadowColor: Colors.grey,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
              ]),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                    maxLines: 2,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price!.round()}',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0 && !isSearch)
                        Text(
                          '${model.oldPrice!.round()}',
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor:
                            AppCubit.get(context).favorites[model.id]!
                                ? defaultColor
                                : Colors.grey,
                        child: IconButton(
                            onPressed: () {
                              AppCubit.get(context).changeFavorites(model.id!);
                            },
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget productInItem(
  ProductsModel model,
  context,
) =>
    Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhysicalModel(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border(
                        bottom: BorderSide(color: defaultColor, width: 2),
                        left: BorderSide(color: defaultColor, width: 2),
                        right: BorderSide(color: defaultColor, width: 2),
                        top: BorderSide(color: defaultColor, width: 2))),
                child: CarouselSlider(
                  items: model.images!
                      .map(
                        (e) => Image(
                          image: NetworkImage(e),
                          width: double.infinity,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 200,
                    initialPage: 0,
                    autoPlay: true,
                    reverse: false,
                    enableInfiniteScroll: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    viewportFraction: 1.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              model.name!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Price ${model.price.round()}',
              style: TextStyle(
                color: defaultColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            if (model.discount != 0)
              Text(
                'Old Price ${model.oldPrice.round()}',
                style: const TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            const SizedBox(height: 20),
            if (model.discount != 0)
              Text(
                'Discount ${model.discount}%',
                style: TextStyle(
                  color: defaultColor,
                ),
              ),
            const SizedBox(height: 20),
            defaultButton(
              background: defaultColor,
              function: () {
                AppCubit.get(context).changeToCart(model.id, context);
              },
              text: inCart ? 'Remove from cart' : 'Add to cart',
              radius: 30,
            ),
            const SizedBox(height: 20),
            defaultButton(
              background: defaultColor,
              function: () {
                AppCubit.get(context).changeFavorites(model.id);
              },
              text: inFavorites ? 'Remove from favorites' : 'Add to favorites',
              radius: 30,
            ),
            const SizedBox(height: 20),
            const Text(
              'Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              model.description!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ));

Widget noItemFallBack({
  required IconData icon,
  required String text,
}) =>
    Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: defaultColor,
            size: 50,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(
                color: Colors.red.withOpacity(0.7),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

Widget cartColumn(GetCartModel model, context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            height: 400,
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
              itemBuilder: (context, index) =>
                  cartItem(model.data!.cartItems![index], context),
              itemCount: model.data!.cartItems!.length,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Totals',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Text(
              'Sub Total',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Text(
              '${model.data!.subTotal}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Text(
              'Total',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Text(
              '${model.data!.total}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: defaultButton(
              radius: 40,
              function: () {},
              text: 'CHECKOUT',
              width: 140,
              isUpperCase: true,
              background: defaultColor),
        ),
      ],
    );

Widget cartItem(CartItems model, context) => SizedBox(
      height: 120,
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  width: 1,
                  color: Colors.grey,
                ),
                image: DecorationImage(
                  image: NetworkImage(model.product!.image!),
                )),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          model.product!.name!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${model.product!.price}EP',
                        style: TextStyle(
                          color: defaultColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.circular(7)),
                      child: defaultIconButton(
                          iconColor: Colors.white,
                          onPressed: () {
                            AppCubit.get(context)
                                .changeToCart(model.product!.id!, context);
                          },
                          icon: Icons.delete_outline),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget columnProfile(ProfileDataModel model, context, state, bool isUpdate) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            PhysicalModel(
              color: defaultColor,
              elevation: 10,
              borderRadius: BorderRadius.circular(80),
              child: CircleAvatar(
                radius: 70,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      image: DecorationImage(
                          image: NetworkImage(model.image), fit: BoxFit.cover)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: isUpdate ? formKey : null,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  defaultTextField(
                    readOnly: !isUpdate,
                    context: context,
                    text: '',
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'name must be valid';
                      }
                      return null;
                    },
                    isOutLineBorder: false,
                    fontInSize: 20,
                    fontInWeight: FontWeight.w900,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultTextField(
                    readOnly: !isUpdate,
                    context: context,
                    text: '',
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'email must be valid';
                      }
                      return null;
                    },
                    isOutLineBorder: false,
                    fontInSize: 20,
                    fontInWeight: FontWeight.w900,
                    type: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  defaultTextField(
                    readOnly: !isUpdate,
                    context: context,
                    text: '',
                    controller: phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'phone must be valid';
                      }
                      return null;
                    },
                    isOutLineBorder: false,
                    fontInSize: 20,
                    fontInWeight: FontWeight.w900,
                    type: TextInputType.emailAddress,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (isUpdate)
              defaultButton(
                  function: () {
                    if (formKey.currentState!.validate()) {
                      AppCubit.get(context).updateProfileData(
                          nameController.text,
                          phoneController.text,
                          emailController.text,
                          passwordController.text);
                      if (state is AppSuccessfulUpdateProfileState) {
                        navigateTo(context, const HomeScreen());
                      }
                    }
                  },
                  text: 'UpDate',
                  isUpperCase: true,
                  radius: 30),
            const SizedBox(height: 20),
            if (!isUpdate)
              defaultTextButton(
                  onPressed: () {
                    navigateTo(context, const ChangePasswordScreen());
                  },
                  text: 'Change password')
          ],
        ),
      ),
    );
