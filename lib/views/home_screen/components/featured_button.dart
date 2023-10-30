import 'package:ecommerce_app/consts/consts.dart';

Widget featuredButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.color(darkFontGrey).fontFamily(semibold).make()
    ],
  )
      .box
      .white
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .p4
      .roundedSM
      .outerShadowSm
      .make();
}
