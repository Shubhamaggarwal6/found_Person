import 'package:flutter/material.dart';
import 'package:found1/screen/firestore_services.dart'; // Import the Firestore service

class statuspage extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missing and Found Persons'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Missing Persons',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<Map<String, dynamic>>>(
                    stream: _firestoreService.getMissingPersons(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No missing persons found.'));
                      }

                      final missingPersons = snapshot.data!;
                      return ListView.builder(
                        itemCount: missingPersons.length,
                        itemBuilder: (context, index) {
                          final person = missingPersons[index];
                          String matchStatus = person['status'] == 1
                              ? 'Match Found'
                              : 'Match Not Found';

                          return ListTile(
                            title: Text('${person['name']} - $matchStatus'),
                            subtitle:
                                Text(person['description'] ?? 'No description'),
                            leading: person['photo'] != null
                                ? Image.network(person['photo'])
                                : null,
                          );
                        },
                      );
                    },
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
