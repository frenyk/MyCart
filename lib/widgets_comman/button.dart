import 'package:emart_app/consts/consts.dart';

Widget ourButton({onPress, Color, textcolor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Color, padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: title!.text.color(textcolor).fontFamily(bold).make());
}
