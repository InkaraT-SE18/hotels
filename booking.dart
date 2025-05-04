class Booking {
  final int? id;
  final String hotelName;
  final String dateRange;
  final String roomType;
  final int guests;
 

  Booking({
    this.id,
    required this.hotelName,
    required this.dateRange,
    required this.roomType,
    required this.guests,
    
  });

  Booking copyWith({
    int? id,
    String? hotelName,
    String? dateRange,
    String? roomType,
    int? guests,
    
  }) {
    return Booking(
      id: id ?? this.id,
      hotelName: hotelName ?? this.hotelName,
      dateRange: dateRange ?? this.dateRange,
      roomType: roomType ?? this.roomType,
      guests: guests ?? this.guests,
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hotelName': hotelName,
      'dateRange': dateRange,
      'roomType': roomType,
      'guests': guests,
      
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      hotelName: map['hotelName'],
      dateRange: map['dateRange'],
      roomType: map['roomType'],
      guests: map['guests'],
     
    );
  }
}
