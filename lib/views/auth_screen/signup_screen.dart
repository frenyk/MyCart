import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/views/homeScreen/home.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import '../../widgets_comman/applogo_widgets.dart';
import '../../widgets_comman/bg_widgets.dart';
import '../../widgets_comman/button.dart';
import '../../widgets_comman/costom_textfild.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());
  //textcontroller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypepasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          appLogoWidget(),
          10.heightBox,
          "Join the $appname".text.fontFamily(bold).white.size(18).make(),
          15.heightBox,
          Obx(
            () => Column(
              children: [
                customTextFild(
                    title: name,
                    hint: namehint,
                    controller: nameController,
                    isPass: false),
                customTextFild(
                    title: email,
                    hint: emailhint,
                    controller: emailController,
                    isPass: false),
                customTextFild(
                    title: password,
                    hint: passwordhint,
                    controller: passwordController,
                    isPass: true),
                customTextFild(
                    title: retypepass,
                    hint: passwordhint,
                    controller: retypepasswordController,
                    isPass: true),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgotpassword.text.make())),
                5.heightBox,
                Row(
                  children: [
                    Checkbox(
                        activeColor: redColor,
                        checkColor: Colors.white,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue!;
                          });
                        }),
                    10.widthBox,
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey),
                            ),
                            TextSpan(
                              text: termandcon,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor),
                            ),
                            TextSpan(
                              text: " & ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey),
                            ),
                            TextSpan(
                              text: Privacypolicy,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                controller.isLoding.value
                    ? const CircularProgressIndicator(
                        color: redColor,
                      )
                    : ourButton(
                        Color: isCheck == true ? redColor : lightGrey,
                        title: signup,
                        textcolor: whiteColor,
                        onPress: () async {
                          if (isCheck != false) {
                            controller.isLoding(true);
                            try {
                              await controller
                                  .signupMethod(
                                      context: context,
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                return controller.storeUserData(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text
                                    );
                              }).then((value) {
                                VxToast.show(context, msg: loggein);
                                Get.offAll(() => Home());
                              });
                            } catch (e) {
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                              controller.isLoding(false);
                            }
                          }
                        }).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: alreadyacc,
                        style: TextStyle(fontFamily: bold, color: fontGrey),
                      ),
                      TextSpan(
                        text: login,
                        style: TextStyle(fontFamily: bold, color: redColor),
                      ),
                    ],
                  ),
                ).onTap(() {
                  Get.back();
                })
              ],
            )
                .box
                .white
                .rounded
                .padding(EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ),
        ],
      )),
    ));
  }
}
