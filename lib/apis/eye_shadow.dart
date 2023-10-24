import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/apis/detail_eye_shadow_api.dart';

class EyeShadowApi extends StatefulWidget {
  const EyeShadowApi({Key? key}) : super(key: key);

  @override
  State<EyeShadowApi> createState() => _EyeShadowApiState();
}

void navigateToProductDetail(
    BuildContext context, Map<String, dynamic> product) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => DetailEyeShadow(product: product),
  ));
}

class _EyeShadowApiState extends State<EyeShadowApi> {
  List<Map<String, dynamic>> eyeShadowData = [];

  @override
  void initState() {
    super.initState();
    fetchEyeShadowApi();
  }

  Future<void> fetchEyeShadowApi() async {
    final dio = Dio();

    try {
      final response = await dio.get(
          'https://makeup-api.herokuapp.com/api/v1/products.json?product_type=eyeshadow');
      if (response.statusCode == 200) {
        final filteredData = List<Map<String, dynamic>>.from(response.data)
            .where((item) =>
                item['image_link'] != null &&
                item['image_link'].startsWith("http"))
            .toList();

        setState(() {
          eyeShadowData = filteredData;
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
      for (int i = 12; i <= 23; i++) i,
      26,
      28,
      34,
      for (int i = 37; i <= 51; i++) i,
      for (int i = 53; i <= 84; i++) i,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eye Shadow',
          style: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: eyeShadowData.isEmpty
            ? const CircularProgressIndicator()
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: indicesToDisplay.length,
                itemBuilder: (context, index) {
                  final itemIndex = indicesToDisplay[index];
                  final item = eyeShadowData[itemIndex];
                  return apiCard(context, item);
                },
              ),
      ),
    );
  }

  Widget apiCard(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        navigateToProductDetail(context, item);
      },
      child: SingleChildScrollView(
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
                          child: GestureDetector(
                            onTap: () {
                              navigateToProductDetail(context, item);
                            },
                            child: Image.network(item['image_link']),
                          ),
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
                                  color: const Color(0xffEE6BCC),
                                ),
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
      ),
    );
  }
}
