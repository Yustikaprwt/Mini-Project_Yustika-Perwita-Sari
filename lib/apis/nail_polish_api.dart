import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';

class NailPolishApi extends StatefulWidget {
  const NailPolishApi({Key? key}) : super(key: key);

  @override
  State<NailPolishApi> createState() => _NailPolishApiState();
}

class _NailPolishApiState extends State<NailPolishApi> {
  List<Map<String, dynamic>> nailPolishData = [];

  @override
  void initState() {
    super.initState();
    fetchNailPolishApi();
  }

  Future<void> fetchNailPolishApi() async {
    final dio = Dio();

    try {
      final response = await dio.get(
          'https://makeup-api.herokuapp.com/api/v1/products.json?product_type=nail_polish');
      if (response.statusCode == 200) {
        final filteredData = List<Map<String, dynamic>>.from(response.data)
            .where((item) =>
                item['image_link'] != null &&
                item['image_link'].startsWith("http"))
            .toList();

        setState(() {
          nailPolishData = filteredData;
        });
      } else {
        print('Gagal mengambil data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<int> indicesToDisplay = [
      for (int i = 14; i <= 59; i++) i,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nail Polish',
          style: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: nailPolishData.isEmpty
            ? const CircularProgressIndicator()
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: indicesToDisplay.length,
                itemBuilder: (context, index) {
                  final itemIndex = indicesToDisplay[index];
                  final item = nailPolishData[itemIndex];
                  return apiCard(context, item);
                },
              ),
      ),
    );
  }

  Widget apiCard(BuildContext context, Map<String, dynamic> item) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: 180,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: Image.network(item['image_link']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              '${item['name']}',
                              style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xffEE6BCC)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Brand: ${item['brand']}',
                              style: GoogleFonts.poppins(fontSize: 13),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.attach_money,
                                  size: 15,
                                ),
                                Text(
                                  '${item['price']}',
                                  style: GoogleFonts.poppins(fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
