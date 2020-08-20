import 'package:cached_network_image/cached_network_image.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tournament/ui/style/style.dart';

class MatchCard extends StatelessWidget {
  final Function onPressed;
final String kill;
final String cost;
final String seatsLeft;
  const MatchCard({Key key, this.onPressed, this.kill, this.cost, this.seatsLeft}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(6
            ),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://s3-alpha-sig.figma.com/img/e5b8/02b7/b699555840ce630f71c634a69252dd39?Expires=1598832000&Signature=Ct9RjkvFTHhzfBaiuvLRSMzohvtUjPtWkEOr61GCYvNoT8n7xDc9fEOKSA7XRbkb3ar3~MnzUToEQH7U0CDxlq6xjlGS~Gvfpe164xBxbImHT7M1i8NeN-2vn1uGlxKW2i~Ocmk8R8RqCDeloEBOxb5hXvvLGSHANurxQFE4dyJHUW2TEI5aPN63IX~pC84O8~RV7oNEFofsMdPbqQ9QVxlodIa9D9tYCTjlx37isnz8Ne4hHxah8YIbfVyJ7nM5aCr7-P51PKWEnvtlgpV~2d6wy~Naeg~scHtyWrae15j2289-xM9kXDJHrNpXZGe1cPaKohpTxnVTVrz~B~QlHw__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    placeholder: (context, text) {
                      return Shimmer.fromColors(
                        baseColor: Colors.red,
                        highlightColor: Colors.yellow,
                        enabled: true,
                        child: Container(
                          height: 150,
                          width: 150,
                        ),
                      );
                    },
//                  color: Theme.of(context).appBarTheme.color.withAlpha(10),
                    progressIndicatorBuilder: (context, text, d) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    top: 110,
                    width: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [ Colors.black26,Colors.black54, Colors.black],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 5,right: 5,
                      child: FittedBox(fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,

                          children: [
                            Text('PUBG MOBILE',style: Style.defaultText,),
                            Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FeatherIcons.dollarSign,
                  color: Colors.white,
                ),
                Text(
                  ' ${'cost'.tr()}/${'kill'.tr()}: \$${'7.5'}/${'15.0'}',
                  style: Style.extraSmallText,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.people_outline,
                  color: Colors.white,
                ),
                Text(
                  ' ${'seats_left'.tr()}: \$${'45'}/${'100'}',
                  style: Style.extraSmallText,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'get_ticket'.tr(),
                style: Style.smallText.copyWith(color: Colors.blueAccent),
              ),
            )
          ],
        ),
      ),
    );
  }
}
