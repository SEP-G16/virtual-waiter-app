import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controller/network/web_socket_controller.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    required this.itemCategory,
    required this.menuItemId,
    required this.menuItemName,
    required this.menuItemImageUrl,
    required this.itemQuantity,
    required this.addOns,
    required this.totalAmount,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  final String itemCategory;
  final String menuItemId;
  final String menuItemName;
  final String menuItemImageUrl;
  final int itemQuantity;
  final List<String> addOns;
  final double totalAmount;
  final Function() onEditPressed;
  final Function() onDeletePressed;

  String _generateAddOnText() {
    String subtext = '';
    if (addOns.isNotEmpty) {
      if (addOns.length == 1) {
        subtext += ' - w/ ${addOns.first}';
      } else {
        String addOnText = ' - w/ ';
        for (String addOn in addOns) {
          if (addOn != addOns.last) {
            addOnText += ('$addOn & ');
          } else {
            addOnText += addOns.last;
          }
        }
        subtext += addOnText;
      }
    }
    return subtext;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0,),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            //Image
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: 80.0,
                height: 80.0,
                imageUrl: menuItemImageUrl,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemCategory,
                style: TextConstants.subTextStyle(fontSize: 18),
              ),
              Text(
                menuItemName,
                style: TextConstants.mainTextStyle(fontSize: 24),
              ),
              RichText(
                text: TextSpan(
                    text: '×',
                    style: TextConstants.subTextStyle(
                        fontSize: 24, textColor: Colors.black),
                    children: [
                      TextSpan(
                        text: '${itemQuantity}',
                        style: TextConstants.subTextStyle(
                            fontSize: 20, textColor: Colors.black),
                      ),
                      TextSpan(
                        text: _generateAddOnText(),
                        style: TextConstants.subTextStyle(
                            fontSize: 20, textColor: Colors.black),
                      ),
                    ]),
              ),
            ],
          ),
          Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: onEditPressed,
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onDeletePressed,
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.redAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            width: 120.0,
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Transform.translate(
                      offset: Offset(0.0, -5.0),
                      child: Text(
                        '\$',
                        style: TextConstants.subTextStyle(
                          fontSize: 20,
                          textColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: '${totalAmount.toStringAsFixed(2)}',
                    style: TextConstants.subTextStyle(
                      fontSize: 30,
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
