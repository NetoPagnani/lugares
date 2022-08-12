import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lugares/providers/greate_places.dart';
import 'package:lugares/utils/app_routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Meus Lugares",
          style: GoogleFonts.acme(
            fontSize: 25,
            fontWeight: FontWeight.w200,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text('Nenhum local cadastrado!'),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.itemsCount == 0
                    ? ch!
                    : ListView.builder(
                        itemCount: greatPlaces.itemsCount,
                        itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                FileImage(greatPlaces.itemByIndex(index).image),
                          ),
                          title: Text(greatPlaces.itemByIndex(index).title),
                          subtitle: Text(greatPlaces
                              .itemByIndex(index)
                              .location!
                              .address!),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.PLACE_DETAIL,
                              arguments: greatPlaces.itemByIndex(
                                index,
                              ),
                            );
                          },
                        ),
                      ),
              ),
      ),
    );
  }
}
