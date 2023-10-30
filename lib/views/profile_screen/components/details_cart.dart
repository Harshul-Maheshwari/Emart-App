import 'package:ecommerce_app/consts/consts.dart';

Widget detailsCart({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.color(darkFontGrey).size(16).fontFamily(semibold).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make()
    ],
  ).box.white.rounded.width(width).height(80).p4.make();
}
