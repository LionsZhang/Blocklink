import 'package:flutter/material.dart';
import 'package:lighthouse/generated/l10n.dart';
import 'package:lighthouse/res/styles.dart';
import 'package:lighthouse/ui/module_base/widget/common_scroll_view.dart';
import 'package:lighthouse/ui/module_base/widget/image/local_image.dart';

class LoadingEmptyTop extends StatelessWidget {

  final double top;
  final String text;
  final String image;

  const LoadingEmptyTop({
    Key key,
    this.top = 50,
    this.text,
    this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScrollView(
        physics: NeverScrollableScrollPhysics(),
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: top),
            child: LocalImage('img_nodata', width: 100, height: 100,),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              text ?? S.of(context).noData,
              style: TextStyles.textGray400_w400_12,
            ),
          ),
        ]);
  }
}