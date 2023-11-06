import 'package:url_launcher/url_launcher.dart';

class MapU
{
  MapU._();

  static void launchMapFromSourceTodestination(sourceLat, sourceLng, destinationLat, destinationLng) async// double datatype
  {
    String mapOptions =
        [
          'saddr=$sourceLat, $sourceLng',
          'daddr=$destinationLat, $destinationLng',
          'dir_action=navigate'
        ].join('&');
    final mapUrl = "https://www.google.com/maps?$mapOptions";
    if(await canLaunch(mapUrl))
      {
        await launch(mapUrl);
      }
    else
      {
        throw "Could not launch $mapUrl ";
      }

  }
}