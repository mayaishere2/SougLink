import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StockHistoryPage extends StatefulWidget {
  final String selectedItem;
  final List<Map<String, dynamic>> items;

  StockHistoryPage({required this.selectedItem, required this.items});

  @override
  State<StockHistoryPage> createState() => _StockHistoryPageState();
}

class _StockHistoryPageState extends State<StockHistoryPage> {
  Map<String, int> stockLevels = {};
  List<Map<String, String>> history = [];
  final TextEditingController itemController = TextEditingController();
  String? currentSelectedItem;
  bool _showDetails = false;

  @override
  void initState() {
    super.initState();
    currentSelectedItem = widget.selectedItem;
  }

  String? getdetails(String item, String wanted) {
    for (var entry in widget.items) {
      if (entry['title'] == item) {
        return entry[wanted] ?? 'Unknown';
      }
    }
    return 'Unknown';
  }

  void _addStock(int amount) {
    if (currentSelectedItem == null || currentSelectedItem!.isEmpty) return;

    setState(() {
      stockLevels[currentSelectedItem!] =
          (stockLevels[currentSelectedItem!] ?? 0) + amount;
      _addToHistory('تمت إضافة $amount كج', 'add');
    });
  }

  void _removeStock(int amount) {
    if (currentSelectedItem == null || currentSelectedItem!.isEmpty) return;

    setState(() {
      stockLevels[currentSelectedItem!] =
          (stockLevels[currentSelectedItem!] ?? 0) - amount;

      if ((stockLevels[currentSelectedItem!] ?? 0) <= 0) {
        stockLevels[currentSelectedItem!] = 0;
        _addToHistory('نفاد المخزون', 'empty');
      } else {
        _addToHistory('تم استهلاك $amount كج', 'remove');
      }
    });
  }

  void _addToHistory(String action, String type) {
    String nowDate = DateTime.now().toLocal().toString().split(' ')[0];
    String nowTime = TimeOfDay.now().format(context);
    String imageAdd = 'assets/images/add.png';
    String imageRemove = 'assets/images/remove.png';
    setState(() {
      history.insert(0, {
        'item': currentSelectedItem ?? '',
        'action': action,
        'date': nowDate,
        'time': nowTime,
        'type': type,
        'image': type == 'add' ? imageAdd : imageRemove,
      });
    });
  }

  List<FlSpot> _generateLineChartData() {
  List<FlSpot> spots = [];
  for (int i = 0; i < history.length; i++) {
    final entry = history[i];
    String type = entry['type'] ?? 'add';
    double x = i.toDouble(); // Use index to represent the time sequence.
    double y = type == 'add'
        ? double.tryParse(entry['action']?.split(' ')[1] ?? '0') ?? 0
        : -(double.tryParse(entry['action']?.split(' ')[1] ?? '0') ?? 0);
    spots.add(FlSpot(x, y));
  }
  return spots.reversed.toList();
}


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(240, 15, 75, 6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    ' المنتج:                  ${widget.selectedItem}',
                    style: TextStyle(
                      fontFamily: 'Kanit',
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                ),
                IconButton(
                  onPressed: () {
                     setState(() {
                       _showDetails = !_showDetails; 
                     });
                  },
                  icon: Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 85,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(getdetails(widget.selectedItem, 'image') ??
                          'assets/images/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ' الكمية المتوفرة حاليًا:   ${getdetails(widget.selectedItem, 'amount')}',
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: 10),
                    Text(
                      ' حالة المخزون:   ${getdetails(widget.selectedItem, 'status')}',
                      style: TextStyle(
                        fontFamily: 'Kanit',
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
      child: Container(
    width: MediaQuery.of(context).size.width * 0.9,
    height: MediaQuery.of(context).size.height * 0.3,
    child: LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index >= 0 && index < history.length) {
                  final entry = history.reversed.toList()[index];
                  return Text(
                    entry['time'] ?? '',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  );
                }
                return Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()} كج',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.white, width: 2),
        ),
        minX: 0,
        maxX: history.length > 1 ? (history.length - 1).toDouble() : 1,
        minY: history.isNotEmpty
    ? history.map((e) {
        double val = e['type'] == 'add'
            ? double.tryParse(e['action']?.split(' ')[1] ?? '0') ?? 0
            : -(double.tryParse(e['action']?.split(' ')[1] ?? '0') ?? 0);
        return val;
      }).reduce((a, b) => a < b ? a : b)
    : 0,
    maxY: history.isNotEmpty
    ? history.map((e) {
        double val = e['type'] == 'add'
            ? double.tryParse(e['action']?.split(' ')[1] ?? '0') ?? 0
            : -(double.tryParse(e['action']?.split(' ')[1] ?? '0') ?? 0);
        return val;
      }).reduce((a, b) => a > b ? a : b)
    : 0,
    
        lineBarsData: [
          LineChartBarData(
            spots: _generateLineChartData(),
            isCurved: true,
            color: Colors.white,
            barWidth: 4,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    ),
      ),
    ),
    
            SizedBox(height: 20),
            Text(
              'تاريخ الاستهلاك:',
              style: TextStyle(
                fontFamily: 'Kanit',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 20),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.18,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 228, 243, 226),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (stockLevels[currentSelectedItem] != null)
                          Expanded(
                            child: ListView.builder(
                              itemCount: history.length,
                              itemBuilder: (context, index) {
                                final entry = history[index];
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        '${entry['image']}',
                                        width: 20,
                                        height: 20,
                                      ),
                                      Flexible(
                                        child: Text(
                                          ' ${entry['action']}      ${entry['time']!}, ${entry['date']!}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Kanit',
                                            fontSize: 14,
                                          ),
                                          textDirection: TextDirection.rtl,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    int amount = int.tryParse(itemController.text) ?? 10;
                    _addStock(amount);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 228, 243, 226),
                    shape: const CircleBorder(),
                    minimumSize: const Size(50, 50),
                  ),
                  child: Icon(Icons.add, size: 28),
                ),
                SizedBox(width: 40),
                ElevatedButton(
                  onPressed: () {
                    int amount = int.tryParse(itemController.text) ?? 10;
                    _removeStock(amount);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 228, 243, 226),
                    shape: const CircleBorder(),
                    minimumSize: const Size(50, 50),
                  ),
                  child: Icon(Icons.remove, size: 28),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

