import 'package:flutter/material.dart';

import 'enums.dart';

class FlightSeatBookingScreen extends StatefulWidget {
  const FlightSeatBookingScreen({super.key});

  @override
  _FlightSeatBookingScreenState createState() => _FlightSeatBookingScreenState();
}

class _FlightSeatBookingScreenState extends State<FlightSeatBookingScreen> {
  List<List<SeatStatus>> seats = List.generate(
      24, (index) => List.generate(6, (index) => SeatStatus.available));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flight Seat Booking'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          _buildHeader(),
          Expanded(child: _buildSeatMap()),
          _buildContinueButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          const Text(
            'DEL - UAE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Text(
            '20 June 2024',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '03h 55m',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(width: 16),
              Icon(Icons.airplanemode_active, color: Colors.orange),
              SizedBox(width: 16),
              Text(
                '1 Adult',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButton<String>(
            value: 'Economy',
            items: ['Economy', 'Business']
                .map((label) => DropdownMenuItem(
              child: Text(label),
              value: label,
            ))
                .toList(),
            onChanged: (value) {},
          ),
        ],
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
              children: List.generate(6, (colIndex) {
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
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.orange,
        ),
        onPressed: () {},
        child: const Text('Continue'),
      ),
    );
  }
}
