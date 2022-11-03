import 'package:flutter/material.dart';
import 'package:otakusukejuru/services/auth_service.dart';

class ImageUser extends StatelessWidget {
  const ImageUser({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    if (AuthService().userImage == null) {
      return CircleAvatar(
        backgroundImage:
            const AssetImage('assets/images/Generic_user_image.png'),
        radius: mediaquery.size.width * 0.14,
      );
    } else {
      return CircleAvatar(
        backgroundImage: NetworkImage(AuthService().userImage),
        radius: mediaquery.size.width * 0.14,
      );
    }
  }
}
