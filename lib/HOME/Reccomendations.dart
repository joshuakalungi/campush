import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'Constants/constants.dart';

class HomePagex extends StatefulWidget {
  const HomePagex({Key? key}) : super(key: key);

  @override
  _HomePagexState createState() => _HomePagexState();
}

class _HomePagexState extends State<HomePagex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[200],
        body: Container(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: GridView(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/MapViewRoute');
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kLightYellow),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on_rounded,
                            size: 50, color: kDarkYellow),
                        SizedBox(width: 20),
                        Text(
                          'placePicker',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/ChannelListPageRoute');
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kLightRed),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_rounded,
                            size: 50, color: kDarkRed),
                        SizedBox(width: 20),
                        Text(
                          'Chatify',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/HomeRoute');
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kLightBlue),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.note_add_sharp, size: 50, color: kDarkBlue),
                        SizedBox(width: 20),
                        Text(
                          'Location Notepad',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/CooletRoute');
                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kLightYellow),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wb_sunny_rounded,
                            size: 50, color: kDarkYellow),
                        SizedBox(width: 80),
                        Text(
                          'Weather',
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    )),
              ),
            ],
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
          ),
        )));
  }
}
