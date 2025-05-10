class Booking {
  final String hotelName;
  final String dateRange;
  final String roomType;
  final int guests;

  Booking({
    required this.hotelName,
    required this.dateRange,
    required this.roomType,
    required this.guests,
  });

  Map<String, dynamic> toMap() {
    return {
      'hotelName': hotelName,
      'dateRange': dateRange,
      'roomType': roomType,
      'guests': guests,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      hotelName: map['hotelName'],
      dateRange: map['dateRange'],
      roomType: map['roomType'],
      guests: map['guests'],
    );
  }
}
