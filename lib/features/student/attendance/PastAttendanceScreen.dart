import 'package:flutter/material.dart';

class PastAttendanceScreen extends StatefulWidget {
  const PastAttendanceScreen({Key? key}) : super(key: key);

  @override
  State<PastAttendanceScreen> createState() => _PastAttendanceScreenState();
}

class _PastAttendanceScreenState extends State<PastAttendanceScreen> {
  int selectedMonth = 1; // January
  int selectedYear = 2026;

  final List<String> months = const [
    "January","February","March","April","May","June",
    "July","August","September","October","November","December"
  ];

  final List<int> years = [2024, 2025, 2026, 2027];

  /// 🔒 DATA EXISTS ONLY FOR JANUARY 2026
  final Map<int, String> january2026Data = {
    for (int i = 1; i <= 18; i++) i: "Present",
    19: "Absent",
    20: "Absent",
    21: "Late",
    22: "Late",
    23: "Late",
    24: "Leave",
  };

  /// Reason storage
  final Map<String, String> reasonData = {};

  bool get isJanuary2026 =>
      selectedMonth == 1 && selectedYear == 2026;

  int _daysInMonth(int y, int m) =>
      DateTime(y, m + 1, 0).day;

  int _startOffset(int y, int m) =>
      DateTime(y, m, 1).weekday % 7;

  Color _statusColor(String status) {
    switch (status) {
      case "Present":
        return Colors.green;
      case "Absent":
        return Colors.red;
      case "Late":
        return Colors.orange;
      case "Leave":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _showReasonDialog(int day, String status) {
    final key = "$selectedYear-$selectedMonth-$day";
    final controller =
        TextEditingController(text: reasonData[key] ?? "");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("$status Reason (Day $day)"),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: "Enter reason",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                reasonData[key] = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int days = _daysInMonth(selectedYear, selectedMonth);
    final int offset = _startOffset(selectedYear, selectedMonth);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6BB6FF),
        title: const Text("PAST ATTENDANCE"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// MONTH + YEAR
            Row(
              children: [
                Expanded(child: _dropdown(
                  DropdownButton<int>(
                    value: selectedMonth,
                    isExpanded: true,
                    items: List.generate(12, (i) =>
                      DropdownMenuItem(
                        value: i + 1,
                        child: Text(months[i]),
                      ),
                    ),
                    onChanged: (v) {
                      if (v != null) setState(() => selectedMonth = v);
                    },
                  ),
                )),
                const SizedBox(width: 12),
                Expanded(child: _dropdown(
                  DropdownButton<int>(
                    value: selectedYear,
                    isExpanded: true,
                    items: years.map((y) =>
                      DropdownMenuItem(
                        value: y,
                        child: Text(y.toString()),
                      ),
                    ).toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => selectedYear = v);
                    },
                  ),
                )),
              ],
            ),

            const SizedBox(height: 20),

            /// 🔥 SUMMARY (TOP IS BACK)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _Summary("18", "Present", Colors.green),
                  _Summary("2", "Absent", Colors.red),
                  _Summary("3", "Late", Colors.orange),
                  _Summary("1", "Leave", Colors.blue),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// WEEKDAYS
            Row(
              children: const [
                "Sun","Mon","Tue","Wed","Thu","Fri","Sat"
              ].map((d) =>
                Expanded(
                  child: Center(
                    child: Text(
                      d,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ).toList(),
            ),

            const SizedBox(height: 8),

            /// CALENDAR GRID
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: offset + days,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemBuilder: (context, index) {
                if (index < offset) return const SizedBox();

                final int day = index - offset + 1;

                final String status = isJanuary2026
                    ? january2026Data[day] ?? "None"
                    : "None";

                final Color color = _statusColor(status);

                return InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if (isJanuary2026 &&
                        (status == "Absent" ||
                         status == "Late" ||
                         status == "Leave")) {
                      _showReasonDialog(day, status);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: status == "None"
                          ? Colors.grey.shade200
                          : color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$day",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color:
                                status == "None" ? Colors.grey : color,
                          ),
                        ),
                        if (status != "None") ...[
                          const SizedBox(height: 4),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                        if (reasonData.containsKey(
                            "$selectedYear-$selectedMonth-$day"))
                          const Icon(
                            Icons.note,
                            size: 12,
                            color: Colors.black54,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropdown(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(child: child),
    );
  }
}

/// SUMMARY WIDGET
class _Summary extends StatelessWidget {
  final String count;
  final String label;
  final Color color;

  const _Summary(this.count, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: color)),
      ],
    );
  }
}
