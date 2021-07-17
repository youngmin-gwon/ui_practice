import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_web/pages/authentication/authentication.dart';
import 'package:flutter_web/pages/clients/clients.dart';
import 'package:flutter_web/pages/drivers/drivers.dart';
import 'package:flutter_web/pages/overview/overview.dart';
import 'package:flutter_web/routers/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overViewPageRoute:
      return _getPageRoute(OverviewPage());
    case driverPageRoute:
      return _getPageRoute(DriversPage());
    case clientPageRoute:
      return _getPageRoute(ClientsPage());
    default:
      return _getPageRoute(OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
