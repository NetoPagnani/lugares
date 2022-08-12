import 'package:flutter/material.dart';
import 'package:lugares/providers/greate_places.dart';
import 'package:lugares/screens/place_detail_screen.dart';
import 'package:lugares/screens/place_form_screen.dart';
import 'package:lugares/screens/places_list_screen.dart';
import 'package:lugares/utils/app_routes.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Meus Lugares',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.indigo,
            secondary: Colors.amber,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const PlacesListScreen(),
        routes: {
          AppRoutes.PLACE_FORM: (context) => PlaceFormScreen(),
          AppRoutes.PLACE_DETAIL: (context) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
