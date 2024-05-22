import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/list.dart';
import 'package:emart_app/controller/auth_controller.dart';
import 'package:emart_app/controller/profile_controller.dart';
import 'package:emart_app/services/firestore_serviece.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/widgets_comman/bg_widgets.dart';
import 'package:emart_app/widgets_comman/button.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';
import 'componets/details_cart.dart';
import 'componets/edit_profilescreen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  var controller = Get.put(ProfileController());
  var i = 0;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirestoreServices.getUser(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  } else {
                    var data = snapshot.data!.docs[i];
                    return SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.edit,
                                color: whiteColor,
                              ),
                            ).onTap(() {
                              controller.nameController.text = data['name'];
                              Get.to(() => EditProfileScreen(
                                    data: data,
                                  ));
                            }),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 80,
                                child: data['imageUrl'] == ''
                                    ? Image.asset(
                                        imgProfile2,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )
                                        .box
                                        .roundedFull
                                        .clip(Clip.antiAlias)
                                        .make()
                                    : Image.network(
                                        data['imageUrl'],
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )
                                        .box
                                        .roundedFull
                                        .clip(Clip.antiAlias)
                                        .make(),
                              ),
                              10.widthBox,
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make(),
                                  "${data['email']}".text.white.make(),
                                ],
                              )),
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: whiteColor),
                                  ),
                                  onPressed: () async {
                                    await Get.put(AuthController())
                                        .signoutMethod(context);
                                    Get.offAll(() => LoginScreen());
                                  },
                                  child: 'Logout'
                                      .text
                                      .fontFamily(semibold)
                                      .white
                                      .make())
                            ],
                          ),
                          20.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detailsCart(
                                  count: data['cart_count'],
                                  title: "in your cart",
                                  Width: context.screenWidth / 3.4),
                              detailsCart(
                                  count: data['wishlist_count'],
                                  title: "in your wishlist",
                                  Width: context.screenWidth / 3.3),
                              detailsCart(
                                  count: data['order_count'],
                                  title: "your oreders",
                                  Width: context.screenWidth / 3.4),
                            ],
                          ),

                          //button

                          ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return const Divider(
                                color: lightGrey,
                              );
                            },
                            itemCount: profileButtonList.length,
                            itemBuilder: (BuildContext context, index) {
                              return ListTile(
                                leading: Image.asset(
                                  profileButtonIcon[index],
                                  width: 22,
                                ),
                                title: profileButtonList[index]
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                              );
                            },
                          )
                              .box
                              .white
                              .rounded
                              .margin(EdgeInsets.all(12))
                              .shadowSm
                              .padding(EdgeInsets.symmetric(horizontal: 16))
                              .make()
                              .box
                              .color(redColor)
                              .make(),
                        ],
                      ),
                    );
                  }
                })));
  }
}
