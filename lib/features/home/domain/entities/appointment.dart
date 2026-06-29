class Appointment {
  final String id;
  final String doctorName;
  final String specialty;
  final String clinicName;
  final String date;
  final String time;
  final String? followUp;

  Appointment({
    required this.id,
    required this.doctorName,
    required this.specialty,
    required this.clinicName,
    required this.date,
    required this.time,
    this.followUp,
  });
}