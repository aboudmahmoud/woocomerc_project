import 'package:flutter/material.dart';
import 'package:woocommerce_api/woocommerce_api.dart';


import 'Confige.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future getProducts() async {
    // Initialize the API
    WooCommerceAPI wooCommerceAPI = WooCommerceAPI(
        url: Confige.url,
        consumerKey: Confige.ConsumerKey,
        consumerSecret: Confige.ConsumerSecret);

    // Get data using the "products" endpoint
    var products = await wooCommerceAPI.getAsync("products/?per_page=100");
    print("Aboud data is $products");
    return products;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(
        future:  getProducts(),
        builder: (_,s){
          return ListView.builder(
              itemCount: s.data.length,
              itemBuilder: (_,index){
                return ListTile(
                  leading: CircleAvatar(
                    child: Image.network(s.data[index]["images"][0]["src"]),
                  ),
                  title: Text(s.data[index]["name"]),
                  subtitle: Text("buy now for ${s.data[index]["price"]}"),
                );
              }
          );
        },
      )
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
