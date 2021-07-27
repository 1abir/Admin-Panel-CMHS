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
                    height: MediaQuery.of(context).size.height*.9,
                    child: Column(
                      children: [
                        if (Responsive.isDesktop(context))
                          Flexible(
                            flex: 2,
                            child: MyFiles(),
                          ),
                        if (Responsive.isDesktop(context))
                          Flexible(
                            flex: 5,
                            child: RecentSessionsView(),
                          ),
                      ],
                    ),
                  ),
                ),
                // On Mobile we don't want to show it here
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: StarageDetails(),
                    ),
                  ),
              ],
            ),
            if (Responsive.isMobile(context)) SizedBox(height: defaultPadding),
            // On Mobile m we want to show it here
            if (Responsive.isMobile(context))
              Container(
                width: MediaQuery.of(context).size.width,
                child: Expanded(
                  child: StarageDetails(),
                ),
              ),
            if (Responsive.isMobile(context)) MyFiles(),
            if (Responsive.isMobile(context)) SizedBox(height: defaultPadding),
            if (Responsive.isMobile(context)) RecentSessionsView(),
            if (Responsive.isMobile(context)) SizedBox(height: defaultPadding),
            if (Responsive.isMobile(context)) StarageDetails(),
            if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
          ],
        ),
      ),
    );
  }
}
