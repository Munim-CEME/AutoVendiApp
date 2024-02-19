import 'package:autovendi/domain/model/location.dart';
import 'package:autovendi/menu_view.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  LocationAxis locationAxis = LocationAxis(x: 0, y: 0, z: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Select Your Area',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder(
              stream: FirebaseDatabase.instance.ref("Locations/").onValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const SizedBox();
                } else {
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, mainAxisSpacing: 12),
                      itemCount: snapshot.data!.snapshot.children.length,
                      padding: const EdgeInsets.all(2.0),
                      itemBuilder: (BuildContext context, int index) {
                        var area = snapshot.data!.snapshot.children
                            .elementAt(index)
                            .key as String;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                locationAxis = LocationAxis.fromJson(snapshot
                                    .data!.snapshot.children
                                    .elementAt(index)
                                    .value as List<Object?>);
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MenuView()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  area,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }
              }),
        ),
      ),
    );
  }
}
