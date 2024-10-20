import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controller/network/web_socket_controller.dart';
import 'package:virtual_waiter/enums/order_item_status.dart';
import 'package:virtual_waiter/model/order_item.dart';

class OrderItemTile extends StatelessWidget {
  OrderItemTile({
    required this.orderItem,
    this.onEditPressed,
    this.onDeletePressed,
    this.pendingPaymentMode = false,
  });

  Function()? onEditPressed;
  Function()? onDeletePressed;
  final OrderItem orderItem;
  bool pendingPaymentMode;

  String _generateAddOnText() {
    List<String> addOns = [];
    addOns.addAll(orderItem.selectedAddOns
        .map((selectedAddOn) => selectedAddOn.addOn.name));
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
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
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
                width: pendingPaymentMode ? 50 : 80.0,
                height: pendingPaymentMode ? 50 : 80.0,
                imageUrl: orderItem.menuItem.imageUrl,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: !pendingPaymentMode,
                child: Text(
                  orderItem.menuItem.category.name,
                  style: TextConstants.subTextStyle(fontSize: 18),
                ),
              ),
              Text(
                orderItem.menuItem.name,
                style: TextConstants.mainTextStyle(fontSize: 24),
              ),
              RichText(
                text: TextSpan(
                    text: 'x ',
                    style: TextConstants.subTextStyle(
                        fontSize: 24, textColor: Colors.black),
                    children: [
                      TextSpan(
                        text: '${orderItem.itemQuantity}',
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
          Builder(
            builder: (context) {
              if (pendingPaymentMode) {
                return SizedBox();
              }
              return orderItem.status != OrderItemStatus.Editing
                  ? Container(
                      margin: EdgeInsets.only(right: 15),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: orderItem.status == OrderItemStatus.Pending
                            ? Colors.black
                            : orderItem.status == OrderItemStatus.Processing
                                ? Colors.amber
                                : orderItem.status == OrderItemStatus.Complete
                                    ? Colors.green
                                    : Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        orderItem.status.toStringAsName(),
                        style: TextConstants.subTextStyle(
                            fontSize: 20, textColor: Colors.white),
                      ),
                    )
                  : Row(
                      children: [
                        GestureDetector(
                          onTap: onEditPressed,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.all(2.5),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.green, width: 2.0),
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
                              border: Border.all(
                                  color: Colors.redAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    );
            },
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
                    text: orderItem.totalAmount.toStringAsFixed(2),
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
