import 'package:cms/core/constants/assets.dart';
import 'package:cms/core/constants/font_heading.dart';
import 'package:cms/core/entities/doctor.dart';
import 'package:cms/core/theme/app_colors.dart';
import 'package:cms/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:cms/features/booking/presentation/cubit/booking_state.dart';
import 'package:cms/features/booking/presentation/screens/booking_success_screen.dart';
import 'package:cms/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookingFormScreen extends StatefulWidget {
  static const routeName = '/booking-form';

  const BookingFormScreen({super.key});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  bool _isDoctorDropdownOpen = false;
  Doctor? _selectedDoctor;

  // Sample doctors – replace with real data
  final List<Doctor> _doctors = [
    Doctor(
      id: '1',
      name: 'Dr. Folan Al.folani',
      experience: '15 years',
      specialty: 'Cardiology',
      imageUrl: Assets.assetsImagesDoctorFolanAlfolani,
    ),
    Doctor(
      id: '2',
      name: 'Dr. Samira Al-Masri',
      experience: '8 years',
      specialty: 'Dentist',
      imageUrl: Assets.assetsImagesDoctorFolanAlfolani,
    ),
    Doctor(
      id: '3',
      name: 'Dr. Khalid Al-Hassan',
      experience: '12 years',
      specialty: 'Ophthalmology',
      imageUrl: Assets.assetsImagesDoctorFolanAlfolani,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BookingCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.main_background_white,
        body: Column(
          children: [
            // ---- Blue Header ----
            _buildBlueHeader(context),
            // ---- Form Body (Scrollable) ----
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // ---- Clinic Section ----
                        _buildClinicSection(),
                        const SizedBox(height: 24),
                        // ---- Doctor Section ----
                        _buildDoctorSection(context),
                        const SizedBox(height: 24),
                        // ---- Date & Time Section ----
                        _buildDateTimeSection(),
                        const SizedBox(height: 24),
                        // ---- Visit Type Section ----
                        _buildVisitTypeSection(),
                        const SizedBox(height: 24),
                        // ---- Reason for Visit ----
                        _buildReasonSection(),
                        const SizedBox(height: 24),
                        // ---- Notes ----
                        _buildNotesSection(),
                        const SizedBox(height: 100), // bottom padding
                      ],
                    ),
                  ),
                  // ---- Doctor Dropdown Overlay ----
                  if (_isDoctorDropdownOpen)
                    Positioned(
                      top: 240, // adjust based on position of doctor section
                      left: 16,
                      right: 16,
                      child: _buildDoctorDropdown(),
                    ),
                ],
              ),
            ),
            // ---- Sticky Bottom Button ----
            _buildBottomButton(context),
          ],
        ),
      ),
    );
  }

  // ============================================================
  //  BLUE HEADER
  // ============================================================
  Widget _buildBlueHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.main_background_blue,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
      child: Row(
        children: [
          // ---- Back Button (Pill-shaped white) ----
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, color: Colors.black, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Back',
                    style: FontHeading.bodySmall.copyWith(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          // ---- Title ----
          Text(
            'Booking appointment',
            style: FontHeading.heading1.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //  CLINIC SECTION
  // ============================================================
  Widget _buildClinicSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Clinic',
          style: FontHeading.heading4.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  Assets.assetsImagesReception,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Some name clinic (Heart)',
                      style: FontHeading.body.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColors.CustomgrayDark,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Damascus, Al-Mazzeh',
                          style: FontHeading.bodySmall.copyWith(
                            color: AppColors.CustomgrayDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  //  DOCTOR SECTION
  // ============================================================
  Widget _buildDoctorSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Doctor',
          style: FontHeading.heading4.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            setState(() {
              _isDoctorDropdownOpen = !_isDoctorDropdownOpen;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // ---- Avatar ----
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _selectedDoctor != null
                      ? Image.asset(
                          Assets.assetsImagesDoctorFolanAlfolani,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          width: 60,
                          height: 60,
                          color: AppColors.customGray,
                          child: Center(
                            child: const FaIcon(
                              FontAwesomeIcons.userMd,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedDoctor?.name ?? 'Any doctor',
                        style: FontHeading.body.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      if (_selectedDoctor != null)
                        Text(
                          '${_selectedDoctor!.experience} of experience',
                          style: FontHeading.bodySmall.copyWith(
                            color: AppColors.customGray,
                          ),
                        ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.CustomgrayDark,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  //  DOCTOR DROPDOWN OVERLAY
  // ============================================================
  Widget _buildDoctorDropdown() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _doctors.map((doctor) {
          final bool isSelected = _selectedDoctor?.id == doctor.id;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDoctor = doctor;
                _isDoctorDropdownOpen = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.grey.shade100
                    : AppColors.main_background_white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(doctor.imageUrl),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      doctor.name,
                      style: FontHeading.body.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    doctor.experience,
                    style: FontHeading.bodySmall.copyWith(
                      color: AppColors.customGray,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ============================================================
  //  DATE & TIME SECTION (with real date/time logic)
  // ============================================================
  DateTime _selectedDate = DateTime.now();
  String _selectedTime = '2:00 PM';
  int _currentMonthOffset = 0;

  Widget _buildDateTimeSection() {
    // Generate dates from today to 2 months forward
    final List<DateTime> visibleDates = _generateDateRange();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred date & time',
          style: FontHeading.heading4.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        // ---- Month Controller ----
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: _currentMonthOffset > 0
                    ? () {
                        setState(() {
                          _currentMonthOffset--;
                        });
                      }
                    : null,
                icon: const Icon(Icons.arrow_back_ios, size: 16),
              ),
            ),
            const SizedBox(width: 24),
            Text(
              _getMonthYear(_currentMonthOffset),
              style: FontHeading.body.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: _currentMonthOffset < 2
                    ? () {
                        setState(() {
                          _currentMonthOffset++;
                        });
                      }
                    : null,
                icon: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // ---- Calendar Grid ----
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Day headers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                    .map(
                      (day) => SizedBox(
                        width: 36,
                        child: Text(
                          day,
                          textAlign: TextAlign.center,
                          style: FontHeading.bodySmall.copyWith(
                            color: AppColors.customGray,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 8),
              // Calendar rows
              ..._buildCalendarRows(visibleDates),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // ---- Time Selector ----
        Row(
          children: [
            Container(
              width: 4,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.main_background_blue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Time:',
              style: FontHeading.body.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: GestureDetector(
                onTap: () => _showTimePicker(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      color: AppColors.customGray,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _selectedTime,
                      style: FontHeading.bodySmall.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_drop_down,
                      color: AppColors.customGray,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  //  DATE GENERATION HELPERS
  // ============================================================
  List<DateTime> _generateDateRange() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month + 2, now.day);
    final List<DateTime> dates = [];
    DateTime current = start;
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      dates.add(current);
      current = current.add(const Duration(days: 1));
    }
    return dates;
  }

  String _getMonthYear(int offset) {
    final now = DateTime.now();
    final target = DateTime(now.year, now.month + offset);
    return '${_monthNames[target.month - 1]} ${target.year}';
  }

  final List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  List<Widget> _buildCalendarRows(List<DateTime> visibleDates) {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(
      now.year,
      now.month + _currentMonthOffset,
      1,
    );
    final daysInMonth = DateTime(
      now.year,
      now.month + _currentMonthOffset + 1,
      0,
    ).day;

    // Calculate first weekday (Monday = 0)
    int firstWeekday =
        firstDayOfMonth.weekday - 1; // Flutter: Monday=1, Sunday=7

    final List<Widget> rows = [];
    int dayCounter = 1;
    int dayIndex = 0;

    // Generate up to 6 rows (max weeks in a month)
    for (int row = 0; row < 6; row++) {
      final List<Widget> cells = [];
      for (int col = 0; col < 7; col++) {
        if (row == 0 && col < firstWeekday) {
          cells.add(const SizedBox(width: 36));
          continue;
        }
        if (dayCounter > daysInMonth) {
          cells.add(const SizedBox(width: 36));
          continue;
        }

        final date = DateTime(
          now.year,
          now.month + _currentMonthOffset,
          dayCounter,
        );
        final bool isToday =
            date.day == now.day &&
            date.month == now.month &&
            date.year == now.year;
        final bool isSelected =
            date.day == _selectedDate.day &&
            date.month == _selectedDate.month &&
            date.year == _selectedDate.year;
        final bool isPast = date.isBefore(
          DateTime(now.year, now.month, now.day),
        );

        cells.add(
          GestureDetector(
            onTap: isPast
                ? null
                : () {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.main_background_blue
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  dayCounter.toString(),
                  style: FontHeading.bodySmall.copyWith(
                    color: isPast
                        ? AppColors.customGray
                        : isSelected
                        ? Colors.white
                        : Colors.black,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        );
        dayCounter++;
      }
      if (cells.isNotEmpty && dayCounter <= daysInMonth + 1) {
        rows.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: cells,
            ),
          ),
        );
      }
    }
    return rows;
  }

  // ============================================================
  //  VISIT TYPE SECTION (Dropdown)
  // ============================================================
  String? _selectedVisitType;
  final List<String> _visitTypes = ['Follow-up visit', 'Regular'];

  Widget _buildVisitTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visit type',
          style: FontHeading.heading4.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedVisitType,
            isExpanded: true,
            hint: Text(
              'Select a visit type',
              style: FontHeading.body.copyWith(color: AppColors.customGray),
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14),
            ),
            icon: Icon(
              Icons.arrow_drop_down,
              color: AppColors.customGray,
              size: 24,
            ),
            items: _visitTypes.map((type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(
                  type,
                  style: FontHeading.body.copyWith(color: Colors.black),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedVisitType = value;
              });
            },
          ),
        ),
      ],
    );
  }

  // ============================================================
  //  REASON FOR VISIT (Adjusted text size)
  // ============================================================
  Widget _buildReasonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Reason for visit (Optional)',
              style: FontHeading.heading4.copyWith(color: Colors.black),
            ),
            const Spacer(),
            // ---- Live counter ----
            Text(
              '${_reasonController.text.length}/200',
              style: FontHeading.bodySmall.copyWith(
                color: AppColors.customGray,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: _reasonController,
            maxLines: 3,
            maxLength: 200,
            style: FontHeading.body.copyWith(color: Colors.black, fontSize: 15),
            onChanged: (value) {
              setState(() {}); // ✅ Refresh counter
            },
            decoration: InputDecoration(
              hintText: 'Briefly describe the reason for your visit...',
              hintStyle: FontHeading.body.copyWith(
                color: AppColors.customGray,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              counterText: '', // ✅ Hide default counter
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  //  NOTES (Adjusted text size)
  // ============================================================
  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Notes (Optional)',
              style: FontHeading.heading4.copyWith(color: Colors.black),
            ),
            const Spacer(),
            // ---- Live counter ----
            Text(
              '${_notesController.text.length}/200',
              style: FontHeading.bodySmall.copyWith(
                color: AppColors.customGray,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: _notesController,
            maxLines: 3,
            maxLength: 200,
            style: FontHeading.body.copyWith(color: Colors.black, fontSize: 15),
            onChanged: (value) {
              setState(() {}); // ✅ Refresh counter
            },
            decoration: InputDecoration(
              hintText: 'Add any additional notes...',
              hintStyle: FontHeading.body.copyWith(
                color: AppColors.customGray,
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
              counterText: '', // ✅ Hide default counter
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  //  BOTTOM BUTTON
  // ============================================================
  Widget _buildBottomButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            // Navigate to success screen
            Navigator.pushNamed(context, BookingSuccessScreen.routeName);
          },
          icon: const Icon(Icons.calendar_today, color: Colors.white, size: 20),
          label: const Text('Book an appointment', style: FontHeading.button),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.main_background_blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  //  TIME PICKER (7:00 AM → 10:00 PM, 15-min increments)
  // ============================================================
  void _showTimePicker(BuildContext context) {
    final List<String> timeSlots = _generateTimeSlots();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.customGray,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Select Time',
                style: FontHeading.heading4.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: timeSlots.length,
                  itemBuilder: (context, index) {
                    final time = timeSlots[index];
                    final bool isSelected = time == _selectedTime;
                    return ListTile(
                      tileColor: isSelected
                          ? AppColors.main_background_blue.withOpacity(0.1)
                          : null,
                      title: Text(
                        time,
                        style: FontHeading.body.copyWith(
                          color: isSelected
                              ? AppColors.main_background_blue
                              : Colors.black,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                      trailing: isSelected
                          ? Icon(
                              Icons.check,
                              color: AppColors.main_background_blue,
                              size: 20,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedTime = time;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<String> _generateTimeSlots() {
    final List<String> slots = [];
    for (int hour = 7; hour <= 22; hour++) {
      for (int minute = 0; minute < 60; minute += 15) {
        // Skip 10:15 PM (22:15) since 10:00 PM is the last slot
        if (hour == 22 && minute > 0) break;
        final period = hour >= 12 ? 'PM' : 'AM';
        final displayHour = hour > 12 ? hour - 12 : hour;
        final displayMinute = minute == 0 ? '00' : minute.toString();
        slots.add('$displayHour:$displayMinute $period');
      }
    }
    return slots;
  }
}
