import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'model/user.dart';


class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary =  const Color(0xffeef44c);

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: Text("My Attendance",style: TextStyle(
                fontFamily: "NexaBold",
                fontSize: screenWidth / 18,
              ),),
            ),
            Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 32),
                  child: Text(DateFormat('MMM').format(DateTime.now()),
                    style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 18,
                  ),),
                ),
              Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(top: 32),
                  child: Text("Pick a Month",style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 18,
                  ),),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight / 1.5,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Employee").doc(User.id).collection("Record").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot){
                  if(snapshot.hasData){
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: snap.length,
                        itemBuilder: (context, index){
                        return Container(
                          margin: const EdgeInsets.only(top: 12, left: 6, right: 6),
                          height: 150,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(2, 2),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(),
                                  decoration: BoxDecoration(
                                    color: primary,
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Center(
                                    child: Text(
                                      snap[index].id,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Check In",style: TextStyle(
                                        fontSize: screenWidth/20,
                                        fontFamily: "NexaRegular",
                                        color: Colors.black54
                                    ),),
                                    Text(snap[index]['checkIn'],
                                      style: TextStyle(
                                      fontSize: screenWidth/18,
                                      fontFamily: "NexaBold",
                                    ),),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Check Out",style: TextStyle(
                                        fontSize: screenWidth/20,
                                        fontFamily: "NexaRegular",
                                        color: Colors.black54
                                    ),),
                                    Text(snap[index]['checkOut'],
                                      style: TextStyle(
                                      fontSize: screenWidth/18,
                                      fontFamily: "NexaBold",
                                    ),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                        },
                    );
                  }else{
                    return const SizedBox();
                  }
            },
              ),
            ),
          ],
        ),
      )
    );
  }
}
