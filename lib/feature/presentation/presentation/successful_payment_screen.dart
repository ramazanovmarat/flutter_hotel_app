import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hotel/feature/presentation/presentation/hotel_screen.dart';

class SuccessfullPaymentScreen extends StatefulWidget {
  final int randomNumber;
  const SuccessfullPaymentScreen({Key? key, required this.randomNumber}) : super(key: key);

  @override
  State<SuccessfullPaymentScreen> createState() => _SuccessfullPaymentScreenState();
}

class _SuccessfullPaymentScreenState extends State<SuccessfullPaymentScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Заказ оплачен'),
        centerTitle: true,
        leading: MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Image.asset('assets/images/vector-3.png'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 23, right: 23, top: 122),
            child: Column(
              children: [
                Image.asset('assets/images/success_icon.png'),
                const SizedBox(height: 32),
                const Text('Ваш заказ принят в работу', style: TextStyle(fontSize: 22)),
                const SizedBox(height: 20),
                Text('Подтверждение заказа №${widget.randomNumber} может занять некоторое время (от 1 часа до суток). Как только мы получим ответ от туроператора, вам на почту придет уведомление.',
                    style: const TextStyle(fontSize: 16, color: Color.fromRGBO(130, 135, 150, 1)), textAlign: TextAlign.center),
              ]),
          ),

          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  border: BorderDirectional(
                    top: BorderSide(color: Color.fromRGBO(232, 233, 236, 1)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12, right: 16, bottom: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HotelScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                        ),
                        child: const Text('Супер', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
    );
  }
}
