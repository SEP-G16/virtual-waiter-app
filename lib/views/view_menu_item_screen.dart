import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:virtual_waiter/components/action_button.dart';
import 'package:virtual_waiter/components/add_subtract_widget.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controller/animation/add_on_icon_animation_controller.dart';
import 'package:virtual_waiter/controller/animation/add_ons_height_animation_controller.dart';
import 'package:virtual_waiter/controller/views/view_menu_item_screen/vmis_state_controller.dart';
import 'package:virtual_waiter/enums/add_on_icon_animation_status.dart';
import 'package:virtual_waiter/enums/height_animation_status.dart';
import 'package:virtual_waiter/model/menu_item.dart';

class ViewMenuItemScreen extends StatelessWidget {
  ViewMenuItemScreen({required this.menuItem}) {
    _vmisStateController = VmisStateController.instance;
  }

  final MenuItem menuItem;
  late final VmisStateController _vmisStateController;
  @override
  Widget build(BuildContext context) {
    _vmisStateController.menuItem = menuItem;
    List<String> tagList = [menuItem.cuisine] + menuItem.tags;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: OrientationBuilder(builder: (context, orientation) {
            double deviceWidth = MediaQuery.of(context).size.width;
            double deviceHeight = MediaQuery.of(context).size.height;
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                            onTap: () {
                              Get.back();
                              _vmisStateController.resetData();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new_outlined,
                              size: 30,
                            )),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Add ${menuItem.name} to your order',
                          style: TextConstants.mainTextStyle(fontSize: 32),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: deviceWidth,
                          height: orientation == Orientation.landscape
                              ? deviceHeight * 0.6
                              : deviceHeight * 0.4,
                          color: Color(0xFF1D1D1B),
                          child: Image(
                            fit: BoxFit.fitHeight,
                            image: CachedNetworkImageProvider(
                              menuItem.imageUrl,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: orientation == Orientation.landscape
                                  ? 120.0
                                  : 20.0,
                              vertical: 20.0),
                          child: Column(
                            children: [
                              Text(
                                'About Meal',
                                style:
                                    TextConstants.mainTextStyle(fontSize: 32),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.article_outlined),
                                            Text(
                                              'Description',
                                              style:
                                                  TextConstants.mainTextStyle(
                                                      fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          menuItem.longDescription,
                                          style: TextConstants.subTextStyle(
                                              fontSize: 18),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                                Icons.monetization_on_outlined),
                                            Text(
                                              'Price',
                                              style:
                                                  TextConstants.mainTextStyle(
                                                      fontSize: 20),
                                            ),
                                          ],
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text:
                                                '\$${menuItem.price.toStringAsFixed(2)}',
                                            style: TextConstants.subTextStyle(
                                                fontSize: 34,
                                                textColor: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: '/per portion',
                                                style:
                                                    TextConstants.subTextStyle(
                                                  fontSize: 18,
                                                  textColor: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                          // softWrap: true,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Visibility(
                                visible: tagList.isNotEmpty,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(MdiIcons.tagMultipleOutline),
                                        Text(
                                          'Tags',
                                          style: TextConstants.mainTextStyle(
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: tagList.map<Widget>((tag) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.amber.withOpacity(0.25),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                            vertical: 5.0,
                                          ),
                                          margin: const EdgeInsets.only(
                                            right: 5.0,
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.brightness_1_rounded,
                                                size: 12,
                                                color: Colors.orangeAccent,
                                              ),
                                              const SizedBox(width: 5.0),
                                              Text(
                                                tag,
                                                style:
                                                    TextConstants.subTextStyle(
                                                        fontSize: 15),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(MdiIcons.chiliMediumOutline),
                                      Text(
                                        'Ingredients',
                                        style: TextConstants.mainTextStyle(
                                            fontSize: 20),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    children: menuItem.ingredients
                                        .map<Widget>((ingredient) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.25),
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                          vertical: 5.0,
                                        ),
                                        margin: const EdgeInsets.only(
                                          right: 5.0,
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.brightness_1_rounded,
                                              size: 12,
                                              color: Colors.green,
                                            ),
                                            const SizedBox(width: 5.0),
                                            Text(
                                              ingredient,
                                              style: TextConstants.subTextStyle(
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                'Complete your Order',
                                style:
                                    TextConstants.mainTextStyle(fontSize: 32),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(MdiIcons.noodles),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Text(
                                            'Quantity',
                                            style: TextConstants.mainTextStyle(
                                                fontSize: 24),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'How many portions of ${menuItem.name} do you want?',
                                        style: TextConstants.subTextStyle(
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  Obx(
                                    () => AddSubtractWidget(
                                      value: _vmisStateController.quantity,
                                      onAddPressed: _vmisStateController
                                          .incrementQuantity,
                                      onSubtractPress: _vmisStateController
                                          .decrementQuantity,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible: menuItem.addOns.isNotEmpty,
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(MdiIcons.plusBox),
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Text(
                                              'Add-Ons',
                                              style:
                                                  TextConstants.mainTextStyle(
                                                      fontSize: 24),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Add some add-ons to your ${menuItem.name} to spice things up!',
                                                style:
                                                    TextConstants.subTextStyle(
                                                        fontSize: 16),
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '*Please make an additional note describing how do you want your add-ons on your portions.',
                                                style:
                                                    TextConstants.subTextStyle(
                                                        fontSize: 13),
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 70),
                                      child: Column(
                                        children: menuItem.addOns
                                            .map<Widget>((addOn) {
                                          String heightAnimatorTag =
                                              'add-on-animator-${addOn['id']}';

                                          String iconAnimatorTag =
                                              'add-on-icon-animator-${addOn['id']}';
                                          Get.put(
                                              AddOnsHeightAnimationController(
                                                  endHeight: 80),
                                              tag: heightAnimatorTag);

                                          Get.put(
                                              AddOnIconAnimationController(),
                                              tag: iconAnimatorTag);

                                          return GetBuilder<
                                              AddOnsHeightAnimationController>(
                                            tag: heightAnimatorTag,
                                            builder: (heightAnimCont) =>
                                                Container(
                                              padding: EdgeInsets.only(
                                                left: 10,
                                                top: 10,
                                                bottom: 10,
                                              ),
                                              margin:
                                                  EdgeInsets.only(bottom: 5.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                border: Border.all(
                                                    color: Colors.green
                                                        .withOpacity(0.5),
                                                    width: 2),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 180,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  addOn['name'],
                                                                  style: TextConstants
                                                                      .subTextStyle(
                                                                          fontSize:
                                                                              20),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            2.0),
                                                                child: Text(
                                                                  '+',
                                                                  style: TextConstants
                                                                      .subTextStyle(
                                                                          fontSize:
                                                                              20),
                                                                ),
                                                              ),
                                                              Text(
                                                                '\$${addOn['price'].toStringAsFixed(2)}',
                                                                style: TextConstants
                                                                    .subTextStyle(
                                                                        fontSize:
                                                                            20),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      GetBuilder<
                                                          AddOnIconAnimationController>(
                                                        tag: iconAnimatorTag,
                                                        builder:
                                                            (iconAnimCont) {
                                                          return Container(
                                                            height: 30,
                                                            width: 40,
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 50),
                                                            alignment: Alignment
                                                                .center,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                if (heightAnimCont
                                                                        .heightAnimateStatus ==
                                                                    HeightAnimateStatus
                                                                        .extended) {
                                                                  heightAnimCont
                                                                      .heightBackwardAnimation();
                                                                } else {
                                                                  heightAnimCont
                                                                      .heightForwardAnimation();
                                                                }

                                                                if (iconAnimCont
                                                                        .animationStatus ==
                                                                    AddOnIconAnimationStatus
                                                                        .addIconDisplayed) {
                                                                  iconAnimCont
                                                                          .isAddIcon =
                                                                      false;
                                                                  _vmisStateController
                                                                      .addAddOnToDataMap(
                                                                          addOnId:
                                                                              addOn['id']);
                                                                } else {
                                                                  iconAnimCont
                                                                          .isAddIcon =
                                                                      true;
                                                                  _vmisStateController
                                                                      .removeAddOnFromDataMap(
                                                                          addOnId:
                                                                              addOn['id']);
                                                                }
                                                              },
                                                              child:
                                                                  AnimatedSwitcher(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        300),
                                                                transitionBuilder: (Widget
                                                                        child,
                                                                    Animation<
                                                                            double>
                                                                        animation) {
                                                                  // Define a slide transition that works both for forward and backward transitions
                                                                  return SlideTransition(
                                                                    position: Tween<
                                                                        Offset>(
                                                                      begin: Offset(
                                                                          0.0,
                                                                          0.0),
                                                                      end: Offset(
                                                                          0.0,
                                                                          0.0),
                                                                    ).animate(
                                                                        animation),
                                                                    child: FadeTransition(
                                                                        opacity:
                                                                            animation,
                                                                        child:
                                                                            child),
                                                                  );
                                                                },
                                                                child: iconAnimCont
                                                                        .isAddIcon
                                                                    ? Icon(
                                                                        MdiIcons
                                                                            .plusCircleOutline,
                                                                        key: ValueKey(
                                                                            'addIcon'),
                                                                        size:
                                                                            30,
                                                                        color: Colors
                                                                            .green,
                                                                      )
                                                                    : Icon(
                                                                        MdiIcons
                                                                            .minusCircleOutline,
                                                                        key:
                                                                            ValueKey(
                                                                          'removeIcon',
                                                                        ),
                                                                        size:
                                                                            30,
                                                                        color: Colors
                                                                            .red,
                                                                      ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: heightAnimCont
                                                                    .heightAnimationValue !=
                                                                null &&
                                                            heightAnimCont
                                                                    .heightAnimationValue
                                                                    ?.value !=
                                                                null
                                                        ? heightAnimCont
                                                                .heightAnimationValue
                                                                ?.value ??
                                                            0
                                                        : 0,
                                                    child: Visibility(
                                                        visible: heightAnimCont
                                                                .heightAnimateStatus ==
                                                            HeightAnimateStatus
                                                                .extended,
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                'How many portions do you want to have this add-on?',
                                                                style: TextConstants
                                                                    .subTextStyle(
                                                                        fontSize:
                                                                            18),
                                                                softWrap: true,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10.0),
                                                              child: Obx(
                                                                () =>
                                                                    AddSubtractWidget(
                                                                  sideLength:
                                                                      40,
                                                                  value: _vmisStateController
                                                                      .getAddOnQuantityValue(
                                                                          addOnId:
                                                                              addOn['id']),
                                                                  onAddPressed:
                                                                      () {
                                                                    _vmisStateController.incrementAddOnQuantity(
                                                                        addOnId:
                                                                            addOn['id']);
                                                                  },
                                                                  onSubtractPress:
                                                                      () {
                                                                    _vmisStateController.decrementAddOnQuantity(
                                                                        addOnId:
                                                                            addOn['id']);
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(MdiIcons.noteEdit),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        'Additional Notes',
                                        style: TextConstants.mainTextStyle(
                                            fontSize: 24),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Write a note our chefs to get a delicious meal!',
                                    style: TextConstants.subTextStyle(
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 70.0),
                                child: Builder(
                                  builder: (context) {
                                    OutlineInputBorder borderStyle =
                                        OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.green.withOpacity(0.5),
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10.0),
                                    );
                                    return TextField(
                                      maxLines: null,
                                      style: TextConstants.subTextStyle(
                                          fontSize: 17),
                                      decoration: InputDecoration(
                                        border: borderStyle,
                                        enabledBorder: borderStyle,
                                        focusedBorder: borderStyle.copyWith(
                                          borderSide: BorderSide(
                                            color: Colors.green,
                                            width: 2,
                                          ),
                                        ),
                                        isDense: true,
                                        isCollapsed: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 10.0),
                                        labelText: 'Write a note here',
                                        labelStyle: TextConstants.subTextStyle(
                                                fontSize: 17)
                                            .copyWith(
                                          color: Colors.grey,
                                        ),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        floatingLabelStyle: TextStyle(
                                            color: Colors.transparent,
                                            fontSize: 0),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Divider(
                                thickness: 1.5,
                                color: Colors.black,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        MdiIcons.cashMultiple,
                                        size: 35,
                                      ),
                                      SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        'Total',
                                        style: TextConstants.mainTextStyle(
                                            fontSize: 32),
                                      ),
                                    ],
                                  ),
                                  Obx(
                                    () => Text(
                                      '\$${_vmisStateController.totalAmount.toStringAsFixed(2)}',
                                      style: TextConstants.subTextStyle(
                                          fontSize: 32),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 8,
                                thickness: 1.5,
                                color: Colors.black,
                              ),
                              Divider(
                                height: 3,
                                thickness: 1.5,
                                color: Colors.black,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ActionButton(
                                    fontSize: 24,
                                    width: 200,
                                    title: 'Add to Orders',
                                    onPressed: () {
                                      _vmisStateController.addOrder();
                                      Get.back();
                                      _vmisStateController.resetData();
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
