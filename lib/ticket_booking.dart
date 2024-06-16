import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'enums.dart';

class FlightSeatBookingScreen extends StatefulWidget {
  const FlightSeatBookingScreen({super.key});

  @override
  _FlightSeatBookingScreenState createState() =>
      _FlightSeatBookingScreenState();
}

class _FlightSeatBookingScreenState extends State<FlightSeatBookingScreen> {
  List<List<SeatStatus>> seats = List.generate(
      24, (index) => List.generate(6, (index) => SeatStatus.available));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBackground(),
          Column(
            children: <Widget>[
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ClipPath(
                        clipper: AirplaneNoseClipper(),
                        child: Container(
                          height: 260,
                          width: MediaQuery.of(context).size.width / 1.5,
                          color: Colors.white,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              const Text('Seating Type'),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    border: Border.all(
                                      color: Colors.deepOrange,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
                                  child: DropdownButton<String>(
                                    value: 'Economy',
                                    items: ['Economy', 'Business']
                                        .map((label) => DropdownMenuItem(
                                              value: label,
                                              child: Text(
                                                label,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    onChanged: (value) {},
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.chair,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        'Available',
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.chair,
                                        color: Colors.orange,
                                      ),
                                      Text(
                                        'Booked',
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.chair,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        'Selected',
                                        style: TextStyle(fontSize: 6),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('A'),
                                  Text('B'),
                                  Text('C'),
                                  Text(' '),
                                  Text('D'),
                                  Text('E'),
                                  Text('F'),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.grey.shade200,
                                height: 0.5,
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width / 1.5,
                        color: Colors.white,
                        child: _buildSeatMap(),
                      ),
                    ],
                  ),
                ),
              ),
              _buildContinueButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/flight_background.jpeg',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
                Icon(
                  Icons.edit_note,
                  color: Colors.white,
                ),
              ],
            ),
            Text(
              '20 June 2024',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'DEL',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '-----',
                  style: TextStyle(color: Colors.orange),
                ),
                Icon(
                  Icons.flight_land,
                  color: Colors.orange,
                ),
                Text(
                  '-----',
                  style: TextStyle(color: Colors.orange),
                ),
                Text(
                  'UAE',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              '03h 55m',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                Text(
                  '1 Adult',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatMap() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(24, (rowIndex) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (colIndex) {
                    SeatStatus status = seats[rowIndex][colIndex];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          seats[rowIndex][colIndex] = status == SeatStatus.available
                              ? SeatStatus.selected
                              : SeatStatus.available;
                        });
                      },
                      child: _buildSeat(status),
                    );
                  }),
                ),
                Text('${rowIndex+1}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (colIndex) {
                    SeatStatus status = seats[rowIndex][colIndex];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          seats[rowIndex][colIndex] = status == SeatStatus.available
                              ? SeatStatus.selected
                              : SeatStatus.available;
                        });
                      },
                      child: _buildSeat(status),
                    );
                  }),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSeat(SeatStatus status) {
    Color color;
    switch (status) {
      case SeatStatus.available:
        color = Colors.grey;
        break;
      case SeatStatus.booked:
        color = Colors.orange;
        break;
      case SeatStatus.selected:
        color = Colors.green;
        break;
    }

    return Container(
      margin: const EdgeInsets.all(4),
      width: 24,
      height: 24,
      child: Icon(
        Icons.chair,
        color: color,
      ),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
        ),
        onPressed: () {},
        child: const Text('Continue'),
      ),
    );
  }
}

class AirplaneNoseClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height / 1);
    path.quadraticBezierTo(
        size.width / 2, -size.height / 2, size.width, size.height / 1);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
