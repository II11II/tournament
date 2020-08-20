import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tournament/ui/style/style.dart';
class PremiumCard extends StatelessWidget {
  final String date;
  final String imageUrl;
  final String title;

  const PremiumCard({Key key, this.date, this.imageUrl, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  FittedBox(
      child: Container(
        height: 180,
        width: 351,
        decoration: BoxDecoration(
            color: Colors.white,

//                  backgroundBlendMode: BlendMode.darken,
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
                image: NetworkImage(
                    'https://s3-alpha-sig.figma.com/img/5eb7/ca14/d0830273729b640adcd5c31a1b968aa2?Expires=1598832000&Signature=MRA5mSJN5McJSb-MB2CTtU2mgyKWfU7zRonXduFgzOab7VovYXz86YTgWa8jx9pdGhJGkZWS1gxcxCCUtBAzXrgqgiJiSV57o8vC~vN2LidEihQlwzBynNpoLjrJzUKbeFkWv4StY~JS0zMRim6eFgKbyCcyJGD9e8u8SBwoNzY-txL51XRwiF69oLGcmnRsUHyORyTz8wcHK2lkyD-rZsn5teB8DRqQ2eoi6X7u0Amh0RcWaRt~KUFTH~0VxuIfLIAmUS3-iRq18cPqpAkDUccxZnAUUbYcmbKdwdZE8WLHGRn4PmJBH7g3ISB7sR3yvr4UciMD4-74lnaR7E9RZg__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.only(left: 22, top: 37, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BOSS LEVEL\nMATCH 2020',
                style:
                TextStyle(shadows: [BoxShadow(color: Colors.black)]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text("premium".tr(),style: Style.defaultText,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.timer,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '13 Aug / 20:00',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(fontWeight: FontWeight.w700),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
