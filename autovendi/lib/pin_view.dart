import 'package:autovendi/locations_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:roslibdart/roslibdart.dart';
import 'domain/model/model.dart';

class PinView extends StatefulWidget {
  const PinView({super.key});

  @override
  State<PinView> createState() => _PinViewState();
}

class _PinViewState extends State<PinView> {
  List<String> compartments = [];
  Map<String, bool> compartmentData = {
    "compartment1": false,
    "compartment2": false,
    "compartment3": false
  };
  late Topic chatter;
  @override
  void initState() {
    super.initState();
    var ros = Ros(url: 'ws://192.168.43.34:9090');
    chatter = Topic(
        ros: ros,
        name: '/mobile_data',
        type: "mobile_data/mobile_data",
        reconnectOnClose: true,
        queueLength: 10,
        queueSize: 10);
    ros.connect();
    print('connected');
    getCompartment();
  }

  void getCompartment() async {
    await FirebaseFirestore.instance
        .collection("products")
        .doc("cart")
        .get()
        .then((value) {
      List<Product> temp = (value.data()!['products']['products'] as List)
          .map((product) => Product.fromSnapshot(product))
          .toList();
      temp.removeAt(0);
      for (var product in temp) {
        compartments.add(product.compartment);
      }
    });
    for (var compartment in compartments) {
      compartmentData[compartment] = true;
    }
    debugPrint('compartmentData: $compartmentData');
  }

  void sendData() async {
    Map<String, dynamic> json = {
      "position": {
        "x": locationAxis.x,
        "y": locationAxis.y,
        "z": locationAxis.z
      },
      "compartment1": (compartmentData["compartment1"]),
      "compartment2": (compartmentData["compartment2"]),
      "compartment3": (compartmentData["compartment3"])
    };
    debugPrint('json: $json');
    print('sending');
    await chatter.publish(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Center(
          child: Text(
            'Pin',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
            stream: FirebaseDatabase.instance.ref("Pin/").onValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const SizedBox();
              } else {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Your Pin is: ',
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: snapshot.data!.snapshot.value.toString(),
                              style: const TextStyle(
                                fontSize: 32,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          sendData();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          'Send Data to ROS',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
