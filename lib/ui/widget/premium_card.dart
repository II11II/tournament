import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tournament/ui/page/home_page/home_cubit.dart';
import 'package:tournament/ui/style/style.dart';

class PremiumCard extends StatelessWidget {

  final Function onPressed;

  const PremiumCard(
      {Key key, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.bloc<HomeCubit>();
    return FittedBox(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 180,
          width: 351,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Colors.black38, BlendMode.darken),
                  image: NetworkImage(
                    "${bloc.state.premiumTournaments[0].image}",
                  ),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(left: 22, top: 37, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${bloc.state.premiumTournaments[0].name}',
                  style: TextStyle(shadows: [BoxShadow(color: Colors.black)]),
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
                          child: Text(
                            "premium".tr(),
                            style: Style.defaultText,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.timer,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      // '13 Aug / 20:00',
                      '${DateFormat.Md('uz').add_Hm().format(bloc.state.premiumTournaments[0].startAt)}',
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
      ),
    );
  }
}
