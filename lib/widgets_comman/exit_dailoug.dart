import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_comman/button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                Color: redColor,
                textcolor: whiteColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                title: "Yes"),
            ourButton(
                Color: redColor,
                textcolor: whiteColor,
                onPress: () {
                  Navigator.pop(context);
                },
                title: "No"),
          ],
        )
      ],
    ).box.color(lightGrey).padding(EdgeInsets.all(12)).rounded.make(),
  );
}
