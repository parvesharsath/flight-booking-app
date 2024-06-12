import 'package:flutter/material.dart';

void main() {
  runApp(FlightBookingApp());
}

class FlightBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Booking',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading ? LogoScreen() : HomePage();
  }
}

class LogoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'images/download.png', // Change this to the actual path of your image
              width: 700,
              height: 500,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flight Booking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Welcome to Flight Booking App',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AvailableFlightsScreen()),
                );
              },
              child: Text('Available Flights'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookedFlightsScreen()),
                );
              },
              child: Text('Booked Flights'),
            ),
          ],
        ),
      ),
    );
  }
}

class AvailableFlightsScreen extends StatefulWidget {
  @override
  _AvailableFlightsScreenState createState() => _AvailableFlightsScreenState();
}

class _AvailableFlightsScreenState extends State<AvailableFlightsScreen> {
  final List<Flight> availableFlights = [
    Flight(
      flightNumber: 'ABC123',
      departure: 'New York',
      destination: 'Los Angeles',
      departureTime: '08:00 AM',
      arrivalTime: '10:30 AM',
      isBooked: false,
    ),
    // Add more flights to Asian countries here
    Flight(
      flightNumber: 'DEF456',
      departure: 'Tokyo',
      destination: 'Beijing',
      departureTime: '10:00 AM',
      arrivalTime: '12:00 PM',
      isBooked: false,
    ),
    Flight(
      flightNumber: 'GHI789',
      departure: 'Seoul',
      destination: 'Bangkok',
      departureTime: '01:30 PM',
      arrivalTime: '04:30 PM',
      isBooked: false,
    ),
    Flight(
      flightNumber: 'JKL012',
      departure: 'Delhi',
      destination: 'Dubai',
      departureTime: '02:45 PM',
      arrivalTime: '06:00 PM',
      isBooked: false,
    ),
    Flight(
      flightNumber: 'ABC123',
      departure: 'New York',
      destination: 'Los Angeles',
      departureTime: '08:00 AM',
      arrivalTime: '10:30 AM',
      isBooked: false,
    ),

    Flight(
      flightNumber: 'GHI789',
      departure: 'Seoul',
      destination: 'Bangkok',
      departureTime: '01:30 PM',
      arrivalTime: '04:30 PM',
      isBooked: false,
    ),
    Flight(
      flightNumber: 'JKL012',
      departure: 'Delhi',
      destination: 'Dubai',
      departureTime: '02:45 PM',
      arrivalTime: '06:00 PM',
      isBooked: false,
  ),
    // Add more flights to Asian countries here
  ];

  List<Flight> filteredFlights = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _populateFlights();
  }

  void _populateFlights() {
    filteredFlights.addAll(availableFlights);
  }

  void _onSearchChanged() {
    String query = _searchController.text;
    setState(() {
      filteredFlights = availableFlights
          .where((flight) =>
          flight.destination.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Flights'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by destination',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredFlights.length,
              itemBuilder: (BuildContext context, int index) {
                final flight = filteredFlights[index];
                return ListTile(
                  title: Text('Flight ${flight.flightNumber}'),
                  subtitle: Text(
                      '${flight.departure} - ${flight.destination}\nDeparture: ${flight.departureTime} | Arrival: ${flight.arrivalTime}'),
                  trailing: ElevatedButton(
                    onPressed: flight.isBooked
                        ? null
                        : () {
                      setState(() {
                        flight.isBooked = true;
                      });
                    },
                    child: Text('Book'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BookedFlightsScreen extends StatelessWidget {
  final List<Flight> bookedFlights = [
    Flight(
      flightNumber: 'JKL345',
      departure: 'Paris',
      destination: 'Berlin',
      departureTime: '02:30 PM',
      arrivalTime: '04:00 PM',
    ),
    Flight(
      flightNumber: 'MNO678',
      departure: 'Moscow',
      destination: 'Istanbul',
      departureTime: '03:45 PM',
      arrivalTime: '06:00 PM',
    ),
    // Add more booked flights here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booked Flights'),
      ),
      body: ListView.builder(
        itemCount: bookedFlights.length,
        itemBuilder: (BuildContext context, int index) {
          final flight = bookedFlights[index];
          return ListTile(
            title: Text('Flight ${flight.flightNumber}'),
            subtitle: Text(
                '${flight.departure} - ${flight.destination}\nDeparture: ${flight.departureTime} | Arrival: ${flight.arrivalTime}'),
          );
        },
      ),
    );
  }
}

class Flight {
  final String flightNumber;
  final String departure;
  final String destination;
  final String departureTime;
  final String arrivalTime;
  bool isBooked;

  Flight({
    required this.flightNumber,
    required this.departure,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    this.isBooked = false,
  });
}
