import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataViewPage extends StatefulWidget {
  @override
  _DataViewPageState createState() => _DataViewPageState();
}

class _DataViewPageState extends State<DataViewPage> {

  // Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('bookings'),
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder(
        stream: firestore.collection('bookings').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;

              // Extract data from the document
              String pickupLocation = data['pickupLocation'];
              String selectedDate = data['selectedDate'];
              String timeSlot = data['selectedTimeSlot'];
              String endDate = data['endDate'];
              String riderName = data['numberOfRiders'];
              String car= data['car'];


              return ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: CircleAvatar(backgroundColor: Colors.deepPurple,),

                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Pickup Location: $pickupLocation'),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Selected Date: $selectedDate'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Selected Time: $timeSlot'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('End Date: $endDate'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Rider Name: $riderName'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('name of car: $car'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

