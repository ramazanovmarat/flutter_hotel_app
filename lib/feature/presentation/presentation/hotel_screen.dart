import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/feature/presentation/bloc/hotel_cubit.dart';
import 'package:hotel/feature/presentation/bloc/hotel_state.dart';
import 'package:hotel/feature/presentation/presentation/number_selection_screen.dart';
import 'package:intl/intl.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({Key? key}) : super(key: key);

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Отель'),
        centerTitle: true,
      ),
      body: BlocBuilder<HotelCubit, HotelState>(
          builder: (BuildContext context, state) {
        if (state is HotelLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HotelLoaded) {
          final hotels = state.hotelEntityLoaded;
          return SingleChildScrollView(
            child: Column(children: [
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                            children: [
                              Padding(
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              child: SizedBox(
                                  height: 257,
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: hotels.image_urls!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 2),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Image.network(
                                            hotels.image_urls![index],
                                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Center(
                                                  child: CircularProgressIndicator(
                                                    value: loadingProgress.expectedTotalBytes != null
                                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              }
                                            },
                                            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                              return const Icon(Icons.error);
                                            },
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      );
                                    },
                                  ))),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.only(top: 232),
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(hotels.image_urls!.length, (index) {
                                    int difference = (_currentPage - index).abs();
                                    int maxVisibleCircles = hotels.image_urls!.length;
                                    double opacity = 1.0 - (difference / maxVisibleCircles).clamp(0.0, 1.0);

                                    if (index == _currentPage) {
                                      opacity = 1.0;
                                    } else {
                                      opacity = opacity * 0.7;
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                      child: Opacity(
                                        opacity: opacity,
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                        ]),
                        Padding(
                            padding: const EdgeInsets.only(left: 16, top: 16),
                            child: IntrinsicWidth(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 199, 0, 0.2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 5, right: 10, bottom: 5),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Color.fromRGBO(255, 168, 0, 1),
                                          size: 15),
                                      const SizedBox(width: 2),
                                      Text(
                                          '${hotels.rating} ${hotels.rating_name}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  255, 168, 0, 1))),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(left: 16, top: 8),
                            child: Text(hotels.name!,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500))),
                        const SizedBox(height: 8),
                        Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: InkWell(
                                onTap: () {},
                                child: Text(
                                  hotels.adress!,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(13, 114, 255, 1)),
                                ))),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 16, bottom: 16),
                            child: Row(children: [
                              Text(
                                  'от ${NumberFormat.decimalPattern("uk-UA").format(hotels.minimal_price)} ₽',
                                  style: const TextStyle(fontSize: 30)),
                              const SizedBox(width: 8),
                              Baseline(
                                  baseline: 25,
                                  baselineType: TextBaseline.alphabetic,
                                  child: Text(hotels.price_for_it!,
                                      style: const TextStyle(
                                          color:
                                              Color.fromRGBO(130, 135, 150, 1),
                                          fontSize: 16))),
                            ])),
                      ])),
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
                        child: Text('Об отеле', style: TextStyle(fontSize: 22)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 26, top: 13),
                        child: Wrap(
                          spacing: 28,
                          runSpacing: 23,
                          children: hotels.peculiarities!
                              .map((e) => Text(e,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromRGBO(130, 135, 150, 1))))
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, top: 17, right: 16),
                        child: Text(hotels.description!,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(0, 0, 0, 0.9))),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 31, top: 31, right: 31),
                        child: Column(children: [
                          RawMaterialButton(
                            onPressed: () {},
                            child: Row(children: [
                              Image.asset('assets/images/emoji-happy.png'),
                              const Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Удобства',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(44, 48, 53, 1),
                                            fontSize: 16)),
                                    Text('Самое необходимое',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                130, 135, 150, 1),
                                            fontSize: 14)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child:
                                      Image.asset('assets/images/Vector55.png'),
                                ),
                              ),
                            ]),
                          ),
                          const Row(children: [
                            SizedBox(width: 35),
                            Expanded(
                                child: Divider(
                              color: Color.fromRGBO(130, 135, 150, 0.15),
                            )),
                          ]),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 31, right: 31),
                        child: Column(children: [
                          RawMaterialButton(
                            onPressed: () {},
                            child: Row(children: [
                              Image.asset('assets/images/tick-square.png'),
                              const Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Что включено',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(44, 48, 53, 1),
                                            fontSize: 16)),
                                    Text('Самое необходимое',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                130, 135, 150, 1),
                                            fontSize: 14)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child:
                                      Image.asset('assets/images/Vector55.png'),
                                ),
                              ),
                            ]),
                          ),
                          const Row(children: [
                            SizedBox(width: 35),
                            Expanded(
                                child: Divider(
                              color: Color.fromRGBO(130, 135, 150, 0.15),
                            )),
                          ]),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 31, right: 31, bottom: 31),
                        child: Column(children: [
                          RawMaterialButton(
                            onPressed: () {},
                            child: Row(children: [
                              Image.asset('assets/images/close-square.png'),
                              const Padding(
                                padding: EdgeInsets.only(left: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Что не включено',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(44, 48, 53, 1),
                                            fontSize: 16)),
                                    Text('Самое необходимое',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                130, 135, 150, 1),
                                            fontSize: 14)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child:
                                      Image.asset('assets/images/Vector55.png'),
                                ),
                              ),
                            ]),
                          ),
                        ]),
                      ),
                    ]),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: BorderDirectional(
                    top: BorderSide(color: Color.fromRGBO(232, 233, 236, 1)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, top: 12, right: 16, bottom: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NumberSelectionScreen(hotelName: hotels.name!)));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                        ),
                        child: const Text('К выбору номера',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          );
        } else if (state is HotelError) {
          final errorMessage = state.message;
          return Center(child: Text(errorMessage));
        } else {
          return const Center(child: Text("No data"));
        }
      }),
    );
  }
}
