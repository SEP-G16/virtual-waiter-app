import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:virtual_waiter/model/menu_item.dart';

import '../constants/text_constants.dart';

class MenuItemTile extends StatelessWidget {
  const MenuItemTile({required this.item, required this.onPressed});

  final MenuItem item;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {

    List<String> tagList = [item.cuisine] + item.tags;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        //MenuItemTile
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(
                  0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              //Image
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(
                          0, 3), // changes position of shadow
                    ),
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  width: 200.0,
                  height: 200.0,
                  imageUrl: item.imageUrl,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: SizedBox(
                height: 165.0,
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextConstants.mainTextStyle(
                          fontSize: 28),
                    ),
                    Text(
                      item.description,
                      style: TextConstants.subTextStyle(
                          fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Visibility(
                      //Tag List
                      visible: tagList.isNotEmpty,
                      child: Row(
                        children: tagList.map<Widget>((item) {
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
                                  item,
                                  style:
                                  TextConstants.subTextStyle(
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: TextConstants.subTextStyle(
                          fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 30.0, left: 20.0),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
