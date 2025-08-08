import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_412/model/favorite.dart';
import 'package:mad_2_412/services/favorite_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Favorite> favorites = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    FavoriteService favoriteService = FavoriteService.instance;
    setState(() {
      _isLoading = true;
    });
    List<Favorite> favorites = await favoriteService.getOrders();
    setState(() {
      this.favorites = favorites;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("favorite".tr, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.red,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : favorites.isEmpty
          ? Center(child: Text("No Data"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                Favorite favorite = favorites[index];
                return ListTile(
                  title: Text("Book ID ${favorite.bookId}"),
                  subtitle: Text("Liked : ${favorite.liked}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await FavoriteService.instance.deleteOrder(favorite.id!);
                      _loadFavorites();
                    },
                  ),
                );
              },
            ),
    );
  }
}
