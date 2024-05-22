import 'dart:io';

import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/widgets_comman/bg_widgets.dart';
import 'package:emart_app/widgets_comman/button.dart';
import 'package:get/get.dart';

import '../../../consts/consts.dart';
import '../../../widgets_comman/costom_textfild.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100,
              child: data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(
                          data['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
            ),
            10.heightBox,
            ourButton(
                Color: redColor,
                onPress: () {
                  controller.changeImage(context);
                },
                textcolor: whiteColor,
                title: "Change"),
            const Divider(),
            20.heightBox,
            customTextFild(
                hint: namehint,
                title: name,
                isPass: false,
                controller: controller.nameController),
            10.heightBox,
            customTextFild(
                hint: passwordhint,
                title: oldpass,
                isPass: true,
                controller: controller.oldpassController),
            10.heightBox,
            customTextFild(
                hint: passwordhint,
                title: newpass,
                isPass: true,
                controller: controller.newpassController),
            20.heightBox,
            controller.isLoading.value
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                        Color: redColor,
                        onPress: () async {
                          controller.isLoading(true);
                          if (controller.profileImgPath.value.isNotEmpty) {
                            await controller.uplodeProfileImg();
                          } else {
                            controller.profilrImgLink = data['imageUrl'];
                          }
                          if (data['password'] ==
                              controller.oldpassController.text) {
                            await controller.changeAuthPassword(
                              email: data['email'],
                              password:controller.oldpassController.text,
                              newpassword: controller.newpassController.text
                            );
                            await controller.updateProfile(
                                imgUrl: controller.profilrImgLink,
                                name: controller.nameController.text,
                                password: controller.newpassController.text);
                            VxToast.show(context, msg: 'Updated');
                          } else {
                            VxToast.show(context, msg: "Wrong Old Password");
                            controller.isLoading(false);
                          }
                        },
                        textcolor: whiteColor,
                        title: "Save"),
                  ),
          ],
        )
            .box
            .white
            .shadowSm
            .padding(EdgeInsets.all(16))
            .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
            .rounded
            .make(),
      ),
    ));
  }
}
