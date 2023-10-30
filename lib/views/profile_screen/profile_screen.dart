import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/consts/lists.dart';
import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/services/firestore_services.dart';
import 'package:ecommerce_app/views/auth_screens/login_screen.dart';
import 'package:ecommerce_app/views/profile_screen/components/details_cart.dart';
import 'package:ecommerce_app/views/profile_screen/edit_profile_screen.dart';
import 'package:ecommerce_app/widgets/bg_widget.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
      child: Scaffold(
          body: StreamBuilder(
              stream: FirestoreServices.getUser(currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ),
                  );
                } else {
                  var data = snapshot.data!.docs[0];
                  return SafeArea(
                      child: Column(
                    children: [
                      // edit profile button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.edit,
                              color: whiteColor,
                            )).onTap(() {
                          controller.nameController.text = data['name'];
                          controller.passController.text = data['password'];
                          Get.to(() => EditProfileScreen(data: data));
                        }),
                      ),

                      // users detail section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            data['imageUrl'] == ''
                                ? Image.asset(imgProfile2,
                                        width: 100, fit: BoxFit.cover)
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make()
                                : Image.network(data['imageUrl'],
                                    width: 100, fit: BoxFit.cover),
                            10.widthBox,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}"
                                    .text
                                    .white
                                    .fontFamily(semibold)
                                    .make(),
                                "${data['email']}".text.white.make(),
                              ],
                            )),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: whiteColor)),
                                onPressed: () async {
                                  await Get.put(AuthController())
                                      .signoutMethod(context);
                                  Get.offAll(() => const LoginScreen());
                                },
                                child: logout.text.white
                                    .fontFamily(semibold)
                                    .make())
                          ],
                        ),
                      ),

                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detailsCart(
                            count: data['cart_count'],
                            title: "in your cart",
                            width: context.screenWidth / 3.4,
                          ),
                          detailsCart(
                            count: data['wishlist_count'],
                            title: "in your wishlist",
                            width: context.screenWidth / 3.4,
                          ),
                          detailsCart(
                            count: data['order_count'],
                            title: "your orders",
                            width: context.screenWidth / 3.4,
                          ),
                        ],
                      ),

                      // buttons section
                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: ((context, index) {
                          return const Divider(
                            color: lightGrey,
                          );
                        }),
                        itemCount: profileButtonsList.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            leading: Image.asset(profileButtonsIcon[index],
                                width: 22),
                            title: profileButtonsList[index]
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                          );
                        }),
                      )
                          .box
                          .white
                          .rounded
                          .margin(const EdgeInsets.all(12))
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .shadowSm
                          .make()
                          .box
                          .color(redColor)
                          .make()
                    ],
                  ));
                }
              })),
    );
  }
}
