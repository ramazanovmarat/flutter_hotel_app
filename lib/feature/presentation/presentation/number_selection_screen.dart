import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel/feature/presentation/bloc/numbers_cubit/number_cubit.dart';
import 'package:hotel/feature/presentation/bloc/numbers_cubit/numbers_state.dart';
import 'package:hotel/feature/presentation/presentation/booking_screen.dart';
import 'package:intl/intl.dart';

class NumberSelectionScreen extends StatefulWidget {
  final String hotelName;
  const NumberSelectionScreen({Key? key, required this.hotelName}) : super(key: key);

  @override
  State<NumberSelectionScreen> createState() => _NumberSelectionScreenState();
}

class _NumberSelectionScreenState extends State<NumberSelectionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.hotelName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        leading: MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Image.asset('assets/images/vector-3.png'),
        ),
      ),
      body: BlocBuilder<NumberCubit, NumberState>(
        builder: (context, state) {
          if (state is NumberLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NumberlLoaded) {
            final hotelNumbers = state.numberEntity;
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              padding: const EdgeInsets.only(top: 8),
              itemCount: hotelNumbers.length,
              itemBuilder: (context, indexRooms) {
                final numberHotelModel = hotelNumbers[indexRooms];
                return Container(
                  padding: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyImageSwipe(images: numberHotelModel.image_urls!),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                        child: Text(numberHotelModel.name!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 26, top: 13),
                        child: Wrap(
                          spacing: 28,
                          runSpacing: 23,
                          children: numberHotelModel.peculiarities!.map((e) =>
                              Text(e, style: const TextStyle(fontSize: 16, color: Color.fromRGBO(130, 135, 150, 1)))).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 16),
                        child: IntrinsicWidth(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              backgroundColor: const Color(0xFFBBDEFB),
                            ),
                            child: Row(
                                children: [
                                  const Text('Подробнее о номере', style: TextStyle(color: Color.fromRGBO(13, 114, 255, 1), fontSize: 16)),
                                  const SizedBox(width: 12),
                                  Image.asset('assets/images/icons.png')
                                ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 16),
                        child: Row(
                          children: [
                            Text('${NumberFormat.decimalPattern("uk-UA").format(numberHotelModel.price)} ₽', style: const TextStyle(fontSize: 30)),
                            const SizedBox(width: 8),
                            Baseline(
                                baseline: 25,
                                baselineType: TextBaseline.alphabetic,
                                child: Text(numberHotelModel.price_per!,
                                    style: const TextStyle(fontSize: 16, color: Color.fromRGBO(130, 135, 150, 1)))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const BookingScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.only(top: 15, bottom: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )
                            ),
                            child: const Text('Выбрать номер', style: TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                    ]),
                );
              });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class MyImageSwipe extends StatefulWidget {
  final List<dynamic> images;

  const MyImageSwipe({super.key, required this.images});

  @override
  _MyImageSwipeState createState() => _MyImageSwipeState();
}

class _MyImageSwipeState extends State<MyImageSwipe> {
  final PageController _pageController = PageController();
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
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(padding: const EdgeInsets.only(left: 14, right: 14),
            child: SizedBox(
                height: 257,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.images.length,
                  itemBuilder: (context, indexPage) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            widget.images[indexPage],
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
        _buildPageIndicator(),
      ]);
  }

  Widget _buildPageIndicator() {
    return Align(
        alignment: Alignment.center,
        child: IntrinsicWidth(
          child: Container(
            margin: const EdgeInsets.only(top: 232),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
                int difference = (_currentPage - index).abs();
                int maxVisibleCircles = widget.images.length;
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
        ));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}