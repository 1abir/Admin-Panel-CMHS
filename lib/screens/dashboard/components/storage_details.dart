import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Session Overview",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc:"assets/icons/media_file.svg",
            title: "Mild",
            amountOfFiles: "300 Sessions",
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            svgSrc:"assets/icons/media_file.svg",
            title: "Moderate",
            amountOfFiles: "250 Sessions",
            numOfFiles: 1000,
          ),
          StorageInfoCard(
            svgSrc:"assets/icons/media_file.svg",
            title: "High",
            amountOfFiles: "200 Sessions",
            numOfFiles: 1500,
          ),
          StorageInfoCard(
            svgSrc:"assets/icons/media_file.svg",
            title: "Severe",
            amountOfFiles: "350 Sessions",
            numOfFiles: 500,
          ),
        ],
      ),
    );
  }
}
