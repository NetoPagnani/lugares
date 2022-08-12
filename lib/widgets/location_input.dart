import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'package:lugares/screens/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lugares/utils/location_util.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPosition;

  const LocationInput(this.onSelectPosition, {Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();

      _showPreview(locData.latitude!, locData.longitude!);
      widget.onSelectPosition(LatLng(
        locData.latitude!,
        locData.longitude!,
      ));
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng? selectetPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(),
      ),
    );

    if (selectetPosition == null) return;

    _showPreview(selectetPosition.latitude, selectetPosition.longitude);
    widget.onSelectPosition(selectetPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? Text('Nenhuma localizaçao informada!')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Localização Atual'),
              onPressed: _getCurrentUserLocation,
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              label: Text('Selecione no Mapa'),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
