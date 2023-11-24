import 'package:url_launcher/url_launcher.dart';

class MapU
{
  MapU._();

  static void launchMapFromSourceTodestinatioan(sourceLat, sourceLng, destinationLat, destinationLng) async// double datatype
  {
    String mapOptions =
        [
          'saddr=$sourceLat, $sourceLng',
          'daddr=$destinationLat, $destinationLng',
          'dir_action=navigate'
        ].join('&');
    final mapUrl =Uri.parse('https://www.google.com/maps?$mapOptions');
    if(await canLaunchUrl(mapUrl))
      {
        await launchUrl(mapUrl);
      }
    else
      {
        throw "Could not launch $mapUrl ";
      }

  }
}