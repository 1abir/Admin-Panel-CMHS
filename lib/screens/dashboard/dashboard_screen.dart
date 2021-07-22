import 'package:admin_panel/responsive.dart';
import 'package:admin_panel/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/header.dart';

import 'components/session_overview.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        if (Responsive.isDesktop(context))
                          Flexible(
                            flex: 3,
                            child: MyFiles(),
                          ),
                        if (Responsive.isMobile(context)) MyFiles(),
                        SizedBox(height: defaultPadding),
                        if (Responsive.isDesktop(context))
                          Flexible(
                            flex: 6,
                            child: RecentSessionsView(),
                          ),
                        if (Responsive.isMobile(context)) RecentSessionsView(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) StarageDetails(),
                      ],
                    ),
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StarageDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
