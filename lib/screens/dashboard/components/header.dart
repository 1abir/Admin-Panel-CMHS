import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.passthrough,
      children: [
        DashBoardMats(
          // key: GlobalKey(),
        ),
        Positioned(
          // key: GlobalKey(),
          // alignment: Alignment.topRight,
          bottom:20,
          left:50,
          // top: defaultPadding,
          // right: defaultPadding,
          child: ProfileCard(),
        ),
      ],
    );
  }
}
class DashBoardMats extends StatelessWidget {
  const DashBoardMats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // key: GlobalKey(),
      children: [
        Row(
          children: [
            if (Responsive.isTablet(context))
              IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    if (!Scaffold.of(context).isDrawerOpen)
                      Scaffold.of(context).openDrawer();
                    // else Scaffold.of(context).
                  } //context.read<MenuController>().controlMenu,
              ),
            if (Responsive.isDesktop(context))
              Text(
                "Dashboard",
                style: Theme.of(context).textTheme.headline6,
              ),
            if (!Responsive.isMobile(context))
              Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
            // Expanded(child: SearchField()),
            Expanded(
                child: SizedBox(
                  width: 5,
                )),
            // if(Responsive.isDesktop(context))ProfileCard(),
            if(Responsive.isDesktop(context))Container(height: 80,width: 200,),
          ],
        ),
        if (Responsive.isMobile(context))
          Column(
            children: [],
          )
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 350,
      child: ExpansionTile(
        initiallyExpanded: true,
        title: Container(
          margin: EdgeInsets.only(left: defaultPadding),
          padding: EdgeInsets.symmetric(
            horizontal: defaultPadding,
            vertical: defaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            children: [
              Image.asset(
                "assets/images/profile_pic.png",
                height: 38,
              ),
              if (!Responsive.isMobile(context))
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  child: Text("Sanjinur Islam"),
                ),
            ],
          ),
        ),
        children: [
          ElevatedButton.icon(
              onPressed: () {
                debugPrint("ontap called");
                final provider =
                    Provider.of<FetchFireBaseData>(context, listen: false);
                provider.logout();
              },
              icon: FaIcon(FontAwesomeIcons.signOutAlt),
              label: Text('Logout'))
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
