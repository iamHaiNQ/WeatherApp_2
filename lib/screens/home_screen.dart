import 'package:flutter/material.dart';
import 'package:weatherapp2/controller/global_controller.dart';
import 'package:get/get.dart';
import 'package:weatherapp2/widgets/current_weather_widget.dart';
import 'package:weatherapp2/widgets/header_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => globalController.checkLoading().isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const HeaderWidget(),

                  CurrentWeatherWidget(
                    weatherDataCurrent: globalController.getWeatherData().getCurrentWeather(),
                  ),
                ],
              )),
      ),
    );
  }
}
