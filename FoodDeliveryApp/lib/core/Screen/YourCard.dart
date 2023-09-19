import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';

class CreditCardScreen extends StatefulWidget {
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  CreditCardScreen({super.key,required this.cardNumber,required this .expiryDate,required this.cardHolderName,required this.cvvCode});

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("Your Visa Card"),
            CreditCardWidget(
              cardBgColor: Colours.lightOrboldOrangeTextangeText,
              cardNumber: widget.cardNumber,
              expiryDate: widget.expiryDate,
              cardHolderName: widget.cardHolderName,
              cvvCode: widget.cvvCode,
              showBackView: false,
              onCreditCardWidgetChange: (CreditCardBrand ) {  },
            ),
          ],
        ),
      ),
    );
  }
}

