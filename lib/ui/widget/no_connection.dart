import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tournament/ui/widget/custom_button.dart';

class NoConnection extends StatelessWidget {
  final Function onPressed;

  const NoConnection({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FeatherIcons.wifiOff,
            color: Colors.blueAccent,
            size: 145,
          ),
          SizedBox(height: 30),
          CustomButton(
            width: 200,
            text: "retry".tr(),
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
