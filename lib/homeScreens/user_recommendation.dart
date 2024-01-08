import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';

class UserRecommendationScreen extends StatefulWidget {
  const UserRecommendationScreen({Key? key}) : super(key: key);

  @override
  _UserRecommendationScreenState createState() => _UserRecommendationScreenState();
}

class _UserRecommendationScreenState extends State<UserRecommendationScreen> {
  Map<String, List<String>> userRecommendations = {};

  @override
  void initState() {
    super.initState();
    generateUserRecommendations();
  }

  Future<Map<String, Map<String, double>>> getItemInteractions() async {
    Map<String, Map<String, double>> itemInteractions = {};

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('user_interactions')
          .doc(sharedPreferences!.getString("uid"))
          .collection('interactions')
          .get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> interaction = doc.data();
        String itemId = interaction['item_id'];
        String action = interaction['action'];
        double interactionValue = 1.0; // You might use different values based on actions

        if (!itemInteractions.containsKey(itemId)) {
          itemInteractions[itemId] = {};
        }

        itemInteractions[itemId]![action] = interactionValue;
      }

      print('Fetched itemInteractions: $itemInteractions');
      return itemInteractions;
    } catch (e) {
      print('Error fetching item interactions: $e');
      return itemInteractions;
    }
  }

  double cosineSimilarity(Map<String, double> vectorA, Map<String, double> vectorB) {
    // Implement cosine similarity calculation between item vectors
    // Calculate dot product
    double dotProduct = 0;
    vectorA.forEach((key, value) {
      if (vectorB.containsKey(key)) {
        dotProduct += value * vectorB[key]!;
      }
    });

    // Calculate magnitudes
    double magnitudeA = vectorA.values.fold(0, (prev, element) => prev + (element * element));
    double magnitudeB = vectorB.values.fold(0, (prev, element) => prev + (element * element));

    if (magnitudeA == 0 || magnitudeB == 0) {
      return 0; //To Handle division by zero or empty vectors
    }

    // Calculating cosine similarity
    double similarity = dotProduct / (magnitudeA * magnitudeB);
    return similarity;
  }


  Map<String, List<String>> generateRecommendations(Map<String, Map<String, double>> itemInteractions) {
    Map<String, List<String>> recommendations = {};
    String userId = 'replace_with_actual_user_id'; // Replace with the actual user ID

    // Get items interacted with by the user
    List<String> userItems = itemInteractions.entries
        .where((entry) => entry.value.containsKey(userId))
        .map((entry) => entry.key)
        .toList();

    // Find similar items for each item the user interacted with
    userItems.forEach((userItem) {
      // Find items similar to the current user item
      List<String> similarItems = [];

      itemInteractions.forEach((itemId, interactions) {
        if (itemId != userItem) {
          double similarityScore = cosineSimilarity(
            itemInteractions[userItem] ?? {},
            interactions,
          );

          if (similarityScore > 0.5) {
            similarItems.add(itemId);
          }
        }
      });

      recommendations[userItem] = similarItems;
    });

    return recommendations;
  }

  Future<void> generateUserRecommendations() async {
    Map<String, Map<String, double>> itemInteractions = await getItemInteractions();
    Map<String, List<String>> recommendations = generateRecommendations(itemInteractions);

    setState(() {
      userRecommendations = recommendations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Recommendations'),
      ),
      body: userRecommendations.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: userRecommendations.length,
        itemBuilder: (context, index) {
          String userItem = userRecommendations.keys.elementAt(index);
          List<String> recommendedItems = userRecommendations[userItem] ?? [];

          return ListTile(
            title: Text('Item: $userItem'),
            subtitle: Text('Recommendations: ${recommendedItems.join(', ')}'),
          );
        },
      ),
    );
  }
}
