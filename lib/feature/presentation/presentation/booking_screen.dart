import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/feature/presentation/bloc/booking_cubit/booking_cubit.dart';
import 'package:hotel/feature/presentation/bloc/booking_cubit/booking_state.dart';
import 'package:hotel/feature/presentation/presentation/successful_payment_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  final maskController = MaskedTextController(mask: '+7 (***) ***-**-**');
  final emailController = TextEditingController();

  bool isPhoneNumberValid = true;
  bool isEmailValid = true;

  List<ContainerItem> containers = [];
  int containerCount = 0;
  final List<String> touristNumbersName = ["Второй", "Третий", "Четвертый", "Пятый", "Шестой", "Седьмой", "Восьмой", "Девятый", "Десятый"];

  void _addContainer() {
    if(containerCount < touristNumbersName.length) {
      setState(() {
        containerCount++;
        containers.add(ContainerItem(touristNumbersName[containerCount - 1],));
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Бронирование'),
        centerTitle: true,
        leading: MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Image.asset('assets/images/vector-3.png'),
        ),
      ),
      body: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          if (state is BookingLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if(state is BookingLoaded) {
            final booking = state.bookingEntity;
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 16, top: 16),
                            child: IntrinsicWidth(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 199, 0, 0.2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.star, color: Color.fromRGBO(255, 168, 0, 1), size: 15),
                                      const SizedBox(width: 2),
                                      Text('${booking.horating} ${booking.rating_name}',
                                          style: const TextStyle(fontSize: 16,
                                              color: Color.fromRGBO(255, 168, 0, 1))),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Text(booking.hotel_name!, style: const TextStyle(fontSize: 22)),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 16),
                            child: RawMaterialButton(
                                onPressed: (){},
                                constraints: const BoxConstraints(),
                                child: Text(booking.hotel_adress!,
                                  style: const TextStyle(fontSize: 14, color: Color.fromRGBO(13, 114, 255, 1)),
                                ))),
                      ]),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Вылет из',
                                  style: TextStyle(fontSize: 16, color: Color.fromRGBO(130, 135, 150, 1)),
                                ),
                              ),
                              Expanded(
                                child: Text(booking.departure!, style: const TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Страна, город',
                                  style: TextStyle(fontSize: 16, color: Color.fromRGBO(130, 135, 150, 1)),
                                ),
                              ),
                              Expanded(
                                child: Text(booking.arrival_country!, style: const TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Даты',
                                  style: TextStyle(fontSize: 16, color: Color.fromRGBO(130, 135, 150, 1)),
                                ),
                              ),
                              Expanded(
                                child: Text('${booking.tour_date_start} - ${booking.tour_date_stop}', style: const TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Кол-во ночей',
                                  style: TextStyle(fontSize: 16, color: Color.fromRGBO(130, 135, 150, 1)),
                                ),
                              ),
                              Expanded(
                                child: Text('${booking.number_of_nights} ночей', style: const TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Отель',
                                  style: TextStyle(fontSize: 16, color: Color.fromRGBO(130, 135, 150, 1)),
                                ),
                              ),
                              Expanded(
                                child: Text(booking.hotel_name!, style: const TextStyle(fontSize: 16), textAlign: TextAlign.left,),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Номер',
                                  style: TextStyle(fontSize: 16, color: Color.fromRGBO(130, 135, 150, 1)),
                                ),
                              ),
                              Expanded(
                                child: Text(booking.room!, style: const TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                child: Text(
                                  'Питание',
                                  style: TextStyle(fontSize: 16, color: Color.fromRGBO(130, 135, 150, 1)),
                                ),
                              ),
                              Expanded(
                                child: Text(booking.nutrition!, style: const TextStyle(fontSize: 16)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16, top: 16),
                          child: Text('Информация о покупателе', style: TextStyle(fontSize: 22)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(246, 246, 249, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              style: const TextStyle(fontSize: 16),
                              controller: maskController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Номер телефона',
                                  hintText: '+7 (***) ***-**-**',
                                  labelStyle: const TextStyle(fontSize: 17, color: Color.fromRGBO(169, 171, 183, 1)),
                                  contentPadding: const EdgeInsets.only(left: 16, bottom: 10, top: 10),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                                ),
                                errorText: isPhoneNumberValid ? null : 'Введите корректный номер телефона',
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(246, 246, 249, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: emailController,
                                style: const TextStyle(fontSize: 16),
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Почта',
                                    labelStyle: const TextStyle(fontSize: 17, color: Color.fromRGBO(169, 171, 183, 1)),
                                    contentPadding: const EdgeInsets.only(left: 16, bottom: 10, top: 10),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                                  ),
                                  errorText: isEmailValid ? null : 'Введите корректный адрес электронной почты',
                                ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Padding(
                          padding: EdgeInsets.only(left: 16, bottom: 16, right: 16),
                          child: Text('Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту',
                          style: TextStyle(color: Color.fromRGBO(130, 135, 150, 1), fontSize: 14),
                          ),
                        ),
                      ]),
                  ),
                  const SizedBox(height: 8),
                  ContainerItem("Первый"),
                Column(children: containers),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _addContainer,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Text('Добавить туриста', style: TextStyle(fontSize: 22, color: Colors.black)),
                          const Spacer(),
                          Image.asset('assets/images/add_icon.png'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text('Тур', style: TextStyle(fontSize: 16, color: Color.fromRGBO(130, 135, 150, 1))),
                              const Spacer(),
                              Text('${NumberFormat.decimalPattern("uk-UA").format(booking.tour_price)} ₽', style: const TextStyle(fontSize: 16)),
                            ]),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text('Топливный сбор', style: TextStyle(fontSize: 16, color: Color.fromRGBO(130, 135, 150, 1)),
                              ),
                              const Spacer(),
                              Text('${NumberFormat.decimalPattern("uk-UA").format(booking.fuel_charge)} ₽', style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text(
                                'Сервисный сбор',
                                style: TextStyle(fontSize: 16, color: Color.fromRGBO(130, 135, 150, 1)),
                              ),
                              const Spacer(),
                              Text('${NumberFormat.decimalPattern("uk-UA").format(booking.service_charge)} ₽', style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Text(
                                'К оплате',
                                style: TextStyle(fontSize: 16, color: Color.fromRGBO(130, 135, 150, 1)),
                              ),
                              const Spacer(),
                              Text('${NumberFormat.decimalPattern("uk-UA").format(booking.tour_price! + booking.fuel_charge! + booking.service_charge!)} ₽', style: const TextStyle(fontSize: 16)),
                            ]),
                        ]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
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
                              final phoneNumber = maskController.text;
                              final email = emailController.text;

                              final isPhoneNumberValid = isValidPhoneNumber(phoneNumber);
                              final isEmailValid = isValidEmail(email);

                              setState(() {
                                this.isPhoneNumberValid = isPhoneNumberValid;
                                this.isEmailValid = isEmailValid;
                              });

                              if (isPhoneNumberValid && isEmailValid) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SuccessfullPaymentScreen(randomNumber: Random().nextInt(900000) + 100000),
                                ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.only(top: 15, bottom: 15),
                            ),
                            child: Text('Оплатить ${NumberFormat.decimalPattern("uk-UA")
                                .format(booking.tour_price! + booking.fuel_charge! + booking.service_charge!)} ₽', style: const TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

bool isValidPhoneNumber(String phoneNumber) {
  return phoneNumber.isNotEmpty;
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  return email.isNotEmpty && emailRegex.hasMatch(email);
}


class ContainerItem extends StatefulWidget {
  final String? touristNumbers;

  ContainerItem(this.touristNumbers, {super.key});

  @override
  _ContainerItemState createState() => _ContainerItemState();
}

class _ContainerItemState extends State<ContainerItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 13, bottom: 13),
              child: Row(
                children: [
                  Text('${widget.touristNumbers ?? ""} Турист', style: const TextStyle(fontSize: 22)),
                  const Spacer(),
                  InkWell(
                    child: Image.asset(isExpanded  ? 'assets/images/icon_button_2.png' : 'assets/images/icon_button.png'),
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                  ),
                ],
              ),
            ),
            if (isExpanded)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 16, right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(246, 246, 249, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 16),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Введите имя';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Имя',
                            labelStyle: TextStyle(fontSize: 17, color: Color.fromRGBO(169, 171, 183, 1)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 16, bottom: 10, top: 10),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:8, horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(246, 246, 249, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 16),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Введите фамилию';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Фамилия',
                            labelStyle: TextStyle(fontSize: 17, color: Color.fromRGBO(169, 171, 183, 1)),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 16, bottom: 10, top: 10),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                          ),
                        ),
                      ),
                    ),
                  ),Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(246, 246, 249, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 16),
                        keyboardType: TextInputType.datetime,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Введите дату рождения';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Дата рождения',
                          labelStyle: TextStyle(fontSize: 17, color: Color.fromRGBO(169, 171, 183, 1)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 16, bottom: 10, top: 10),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:8, horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(246, 246, 249, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 16),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Введите гражданство';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Гражданство',
                          labelStyle: TextStyle(fontSize: 17, color: Color.fromRGBO(169, 171, 183, 1)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 16, bottom: 10, top: 10),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(246, 246, 249, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 16),
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Введите номер загранпаспорта';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Номер загранпаспорта',
                          labelStyle: TextStyle(fontSize: 17, color: Color.fromRGBO(169, 171, 183, 1)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 16, bottom: 10, top: 10),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16, top: 8, left: 16, right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(246, 246, 249, 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        style: const TextStyle(fontSize: 16),
                        keyboardType: TextInputType.datetime,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Введите срок действия загранпаспорта';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Срок действия загранпаспорта',
                          labelStyle: TextStyle(fontSize: 17, color: Color.fromRGBO(169, 171, 183, 1)),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 16, bottom: 10, top: 10),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(235, 87, 87, 0.15)),
                          ),
                        ),
                      ),
                    ),
                  ),

                ]),
          ]),
      ),
    );
  }
}


