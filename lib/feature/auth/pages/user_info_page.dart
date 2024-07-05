import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/extension/custom_theme_extension.dart';
import 'package:whatsapp_messenger/common/utils/coloors.dart';
import 'package:whatsapp_messenger/common/widgets/custom_elevated_button.dart';
import 'package:whatsapp_messenger/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_messenger/common/widgets/short_h_bar.dart';
import 'package:whatsapp_messenger/feature/auth/widgets/custom_text_field.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  imagePickerTypeBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ShortHBar(),
              Row(
                children: [
                  const SizedBox(width: 20),
                  const Text(
                    'Profile photo',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  CustomIconButton(
                    onTap: () => Navigator.pop(context),
                    icon: Icons.close,
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              Divider(
                color: context.theme.greyColor!.withOpacity(0.3),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const SizedBox(width: 20),
                  imagePickerIcon(
                    onTap: () {},
                    icon: Icons.camera_alt_rounded,
                    text: 'Camera',
                  ),
                  const SizedBox(width: 15),
                  imagePickerIcon(
                    onTap: () {},
                    icon: Icons.photo_camera_back_rounded,
                    text: 'Gallery',
                  ),
                ],
              ),
              const SizedBox(height: 15),
            ],
          );
        });
  }

  imagePickerIcon({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
  }) {
    return Column(
      children: [
        CustomIconButton(
          onTap: onTap,
          icon: icon,
          iconColor: Coloors.greenDark,
          minWidth: 50,
          border: Border.all(
            color: context.theme.greyColor!.withOpacity(.2),
            width: 1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(color: context.theme.greyColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Profile info',
          style: TextStyle(
            color: context.theme.authAppbarTextColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              'Please provide your name and an optional profile photo',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.theme.greyColor,
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: imagePickerTypeBottomSheet,
              child: Container(
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.photoIconBgColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 3, right: 3),
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    size: 48,
                    color: context.theme.photoIconColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const SizedBox(width: 20),
                const Expanded(
                    child: CustomTextField(
                  hintText: 'Type your name here',
                  textAlign: TextAlign.left,
                  autoFocus: true,
                )),
                const SizedBox(width: 10),
                Icon(
                  Icons.emoji_emotions_outlined,
                  color: context.theme.photoIconColor,
                ),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
        onPressed: () {},
        text: 'NEXT',
        buttonWidth: 90,
      ),
    );
  }
}
