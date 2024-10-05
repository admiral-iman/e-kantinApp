import 'package:e_kantin/views/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MejaPage extends StatefulWidget {
  @override
  _MejaPageState createState() => _MejaPageState();
}

class _MejaPageState extends State<MejaPage> {
  TextEditingController tableNumberController =
      TextEditingController(text: '0');
  TextEditingController numberOfPeopleController =
      TextEditingController(text: '0');

  void _updateValue(String field, int delta) {
    final controller =
        field == 'No Meja' ? tableNumberController : numberOfPeopleController;
    int currentValue = int.tryParse(controller.text) ?? 0;
    int newValue = (currentValue + delta).clamp(0, 100);
    controller.text = newValue.toString();
  }

  @override
  void dispose() {
    tableNumberController.dispose();
    numberOfPeopleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Meja', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildSelectionTile('No Meja', tableNumberController),
                _buildSelectionTile('Jumlah Orang', numberOfPeopleController),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman feedback
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FeedbackPage(),
                  ),
                );
              },
              child: Text('Lanjut', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionTile(String title, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Colors.black54)),
          Row(
            children: [
              _buildIconButton(Icons.remove, () => _updateValue(title, -1)),
              SizedBox(width: 16),
              SizedBox(
                width: 50,
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _MaxValueFormatter(100),
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 16),
              _buildIconButton(Icons.add, () => _updateValue(title, 1)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.orange),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.orange),
        onPressed: onPressed,
        constraints: BoxConstraints.tightFor(width: 40, height: 40),
        padding: EdgeInsets.zero,
      ),
    );
  }
}

class _MaxValueFormatter extends TextInputFormatter {
  final int maxValue;

  _MaxValueFormatter(this.maxValue);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    int? value = int.tryParse(newValue.text);
    if (value == null || value > maxValue) {
      return oldValue;
    }
    return newValue;
  }
}
