import 'package:flutter/material.dart';

import 'meja.dart';

class PesananPage extends StatefulWidget {
  final List<Map<String, dynamic>> orderItems;

  PesananPage({required this.orderItems});

  @override
  _PesananPageState createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  int get totalItems =>
      widget.orderItems.fold(0, (sum, item) => sum + item['quantity'] as int);
  int get totalPrice => widget.orderItems
      .fold(0, (sum, item) => sum + (item['price'] * item['quantity']) as int);

  void updateQuantity(int index, int delta) {
    setState(() {
      widget.orderItems[index]['quantity'] =
          (widget.orderItems[index]['quantity'] + delta).clamp(0, 99);
      if (widget.orderItems[index]['quantity'] == 0) {
        widget.orderItems.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Pesanan', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.orderItems.length,
              itemBuilder: (context, index) {
                final item = widget.orderItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item['image'],
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              item['description'],
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Rp ${item['price']}',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: Colors.orange),
                              onPressed: () => updateQuantity(index, -1),
                            ),
                            Text('${item['quantity']}',
                                style: TextStyle(fontSize: 16)),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.orange),
                              onPressed: () => updateQuantity(index, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: Rp $totalPrice',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi kembali ke MejaPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MejaPage()),
                    ).then((selectedTable) {
                      if (selectedTable != null) {
                        // Lakukan sesuatu jika meja dipilih
                      }
                    });
                  },
                  child: Text('Pilih Meja'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
