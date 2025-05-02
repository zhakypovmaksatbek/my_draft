import 'package:dgis_mobile_sdk_map/dgis.dart' as sdk;
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final sdk.Context sdkContext;
  late final sdk.MapWidgetController mapWidgetController;
  @override
  void initState() {
    sdkContext = sdk.DGis.initialize();
    mapWidgetController = sdk.MapWidgetController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sdk.MapWidget(sdkContext: sdkContext, mapOptions: sdk.MapOptions()),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
