import 'package:flutter/material.dart';
import 'package:otakusukejuru/services/auth_service.dart';

class ImageUser extends StatelessWidget {
  const ImageUser({super.key});

  @override
  Widget build(BuildContext context) {
    if (AuthService().userImage == null) {
      return const CircleAvatar(
        backgroundImage: AssetImage('assets/images/Generic_user_image.png'),
        radius: 50,
      );
    } else {
      return CircleAvatar(
        backgroundImage: NetworkImage(AuthService().userImage),
        radius: 50,
      );
    }
  }
}
