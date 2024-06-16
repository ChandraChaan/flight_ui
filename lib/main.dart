import 'package:flight_ticket_ui/ticket_booking.dart';
import 'package:flutter/material.dart';

void main() => runApp(const FlightSeatBookingApp());

class FlightSeatBookingApp extends StatelessWidget {
  const FlightSeatBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flight Seat Booking',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const FlightSeatBookingScreen(),
    );
  }
}

