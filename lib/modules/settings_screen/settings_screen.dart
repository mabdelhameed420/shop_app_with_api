import 'package:flutter/material.dart';
import '../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:
            const EdgeInsetsDirectional.only(start: 20, bottom: 20, top: 20),
        child: Column(
          children: [
            // This only a design for Settings Screen
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Text(
                    'Privacy',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  defaultIconButton(
                      onPressed: () {}, icon: Icons.keyboard_double_arrow_right)
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            divider(),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Text(
                    'Rules',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  defaultIconButton(
                      onPressed: () {}, icon: Icons.keyboard_double_arrow_right)
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            divider(),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Text(
                    'Rules',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  defaultIconButton(
                      onPressed: () {}, icon: Icons.keyboard_double_arrow_right)
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            divider(),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Text(
                    'History of your Order',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  defaultIconButton(
                      onPressed: () {}, icon: Icons.keyboard_double_arrow_right)
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            divider(),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  const Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  defaultIconButton(
                      onPressed: () {}, icon: Icons.keyboard_double_arrow_right)
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
