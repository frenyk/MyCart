import 'package:emart_app/consts/consts.dart';

Widget detailsCart({Width , String? count , String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text.fontFamily(bold).color(darkFontGrey).make()
    ],
  )
      .box
      .white
      .rounded
      .white
      .width(Width)
      .padding(EdgeInsets.all(4))
      .height(80)
      .make();
}
