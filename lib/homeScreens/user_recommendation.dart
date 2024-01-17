import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:my_tiffin/widgets/popular_item.dart';

class UserRecommendationScreen extends StatefulWidget {
  Items? model;
   UserRecommendationScreen({
     super.key,
     this.model
});

  @override
  _UserRecommendationScreenState createState() => _UserRecommendationScreenState();
}

class _UserRecommendationScreenState extends State<UserRecommendationScreen> {
  Map<String, List<String>> userRecommendations = {};

  @override
  void initState() {
    super.initState();
    fetchAndSetUserRecommendations();
  }

  Future<Map<String, Map<String, double>>> getItemInteractions() async {
    Map<String, Map<String, double>> interactions = {};

    try {
      DateTime threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('user_interactions')
          .doc(sharedPreferences!.getString("uid"))
          .collection('interactions')
          .where('timestamp', isGreaterThanOrEqualTo: threeDaysAgo)
          .get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> interaction = doc.data();
        String itemId = interaction['item_id'];
        String action = interaction['action'];
        double interactionValue = 1.0;

        if (!interactions.containsKey(itemId)) {
          interactions[itemId] = {};
        }

        interactions[itemId]![action] = interactionValue;
      }

      print('Fetched itemInteractions: $interactions');
      return interactions;
    } catch (e) {
      print('Error fetching item interactions: $e');
      return interactions;
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

  Map<String, List<String>> generateRecommendations(Map<String, Map<String, double>> itemInteractions, String clickedItemId) {
    Map<String, List<String>> recommendations = {};
    String? userId = sharedPreferences!.getString("uid");

    List<String> interactedItems = itemInteractions.keys.toList();

    if (interactedItems.isNotEmpty) {
      print("Interacted items: ${interactedItems.join(', ')}");
    } else {
      print("No interacted items found.");
      return recommendations; // Return an empty map if there are no interacted items
    }

    List<String> similarItems = [];

    // Calculate cosine similarity with the clicked item
    Map<String, double> clickedItemVector = itemInteractions[clickedItemId] ?? {};

    interactedItems.forEach((otherItemId) {
      if (otherItemId != clickedItemId) {
        // Print statements for debugging
        print('Clicked Item ID: $clickedItemId, Vector: $clickedItemVector');
        print('Other Item ID: $otherItemId, Vector: ${itemInteractions[otherItemId]}');

        double similarityScore = cosineSimilarity(
          clickedItemVector,
          itemInteractions[otherItemId] ?? {}, // Interaction vector for the other item being compared
        );

        // Print statement for debugging
        print('Similarity Score: $similarityScore');

        if (similarityScore > 0.3) {
          similarItems.add(otherItemId);
        }
      }
    });

    recommendations[clickedItemId] = similarItems;
    print('Clicked Item ID: $clickedItemId, Similar Item IDs: $similarItems');

    return recommendations;
  }

  Future<void> fetchAndSetUserRecommendations() async {
    String clickedItemId = widget!.model!.itemID;
    Map<String, Map<String, double>> itemInteractions = await getItemInteractions();
    Map<String, List<String>> recommendations = generateRecommendations(itemInteractions, clickedItemId);
    print('Recommendations for $clickedItemId: $recommendations');

    print('User Recommendations: $recommendations');
    setState(() {
      userRecommendations = recommendations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 15, 10),
          width: double.infinity,
          child: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('items')
                  .orderBy("publishedDate", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  QuerySnapshot<Map<String, dynamic>> querySnapshot = snapshot.data as QuerySnapshot<Map<String, dynamic>>;
                  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;

                  List<String> recommendedItemIds = userRecommendations.values.expand((items) => items).toList();
                  print('Recommended Item IDs: $recommendedItemIds');
                  List<Items> recommendedItems = docs
                      .where((doc) => recommendedItemIds.contains(doc.id)) // Filtering based on recommended item IDs
                      .map((doc) => Items.fromJson(doc.data()))
                      .toList();
                  return Container(
                    width: 350,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: recommendedItems.length,
                      itemBuilder: (context, index) {
                        return PopularShownItems(
                          model: recommendedItems[index],
                          context: context,
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
