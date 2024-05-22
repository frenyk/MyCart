import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/card_controller.dart';
import 'package:emart_app/widgets_comman/button.dart';
import 'package:emart_app/widgets_comman/costom_textfild.dart';
import 'package:get/get.dart';

import 'paymant.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CardController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping info"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            onPress: () {
              if (controller.addressController.text.length > 10) {
                Get.to(() => PaymentMethods());
              } else {
                VxToast.show(context, msg: "Please fill the form");
              }
            },
            Color: redColor,
            textcolor: whiteColor,
            title: "Continue"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            customTextFild(
                hint: "Address",
                title: "Address",
                isPass: false,
                controller: controller.addressController),
            customTextFild(
                hint: "City",
                title: "City",
                isPass: false,
                controller: controller.cityController),
            customTextFild(
                hint: "State",
                title: "State",
                isPass: false,
                controller: controller.stateController),
            customTextFild(
                hint: "Postal Code",
                title: "Postal Code",
                isPass: false,
                controller: controller.postalCodeController),
            customTextFild(
                hint: "Phone",
                title: "Phone",
                isPass: false,
                controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
