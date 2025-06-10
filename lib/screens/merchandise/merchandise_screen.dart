import 'dart:convert';

import 'package:assihnment_technolitocs/screens/merchandise/merchandise_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../config/model/merchandise_product_model.dart';

class Merchandise extends ConsumerStatefulWidget {
  const Merchandise({super.key});

  @override
  ConsumerState<Merchandise> createState() => _MerchandiseState();
}

class _MerchandiseState extends ConsumerState<Merchandise> {
  late Future<List<MerchandiseProduct>> products;

  Future<List<MerchandiseProduct>> fetchMerchandiseProducts() async {
    final url =
        "https://api.rolbol.org/api/v1/product/byAnyCategory/?page=1&limit=8";
    try {
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final decodedData = data['data'] as List<dynamic>;
        // print(decodedData);
        return decodedData
            .map((item) => MerchandiseProduct.fromJson(item))
            .toList()
            .cast<MerchandiseProduct>();
      } else {
        // Handle error: return empty list or throw
        return [];
      }
    } catch (e) {
      // Optionally log error
      rethrow;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    products = fetchMerchandiseProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white, // or any light color
          statusBarIconBrightness: Brightness.dark, // // lack icons
        ),
        title: Text(
          "Merchandise",
          style: TextStyle(
            fontFamily: 'Movatif',
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: ColorFiltered(
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            child: Image.asset(
              'assets/images/backward_arrow.png',
              width: 24,
              height: 24,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SizedBox(height: 30,),
              FutureBuilder(
                future: products,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );

                  if (snapshot.hasError) {
                    print(snapshot.error.toString());
                    return Center(
                      child: Text("//////////" + snapshot.error.toString()),
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 300,
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        // mainAxisSpacing: 20,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final product = snapshot.data![index];
                        return productCard(product);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productCard(MerchandiseProduct product) {
    final price =
        double.tryParse(product.rows[0].perProductPrice.toString()) ?? 0;
    final mrp =
        double.tryParse(product.rows[0].mrp.toString()) ??
        1; // Avoid division by zero
    final discount =
        "(" + ((100 - price / mrp * 100)).toStringAsFixed(0) + "% OFF)";

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MerchandiseProductPage(product: product),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        height: 400,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0x2a000000), width: 1),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15), // Shadow color
              spreadRadius: 2, // How much the shadow spreads
              blurRadius: 8, // Softness of the shadow
              offset: Offset(0, 0), // Position of shadow (x, y)
            ),
          ],
          // color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  '${product.images[0].values[0].url}',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,

                  // width: MediaQuery.of(context).size.width/2-20,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              product.title,
              style: TextStyle(
                fontFamily: 'Movatif',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Row(
              // mainAxisAlignment: MainAxisAlignment.d,
              children: [
                SizedBox(width: 10),
                Text(
                  "₹" + product.rows[0].perProductPrice.toString(),
                  style: TextStyle(
                    fontFamily: 'Movatif',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                SizedBox(width: 10),
                Text(
                  "₹" + product.rows[0].mrp.toString(),
                  style: TextStyle(
                    fontFamily: 'Movatif',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),

                SizedBox(width: 10),

                Text(
                  discount,
                  style: TextStyle(
                    fontFamily: 'Movatif',
                    fontSize: 17,
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.w400,
                    // decoration: TextDecoration.lineThrough
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
