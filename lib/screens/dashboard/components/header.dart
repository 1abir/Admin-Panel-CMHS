import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/constants.dart';
import 'package:admin_panel/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.passthrough,
      children: [
        DashBoardMats(),
        // Positioned(
        //   top: defaultPadding,
        //   right: defaultPadding,
        //   child: ProfileCard(),
        // ),
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
            // if (!Responsive.isMobile(context))
            //   Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
            // Expanded(child: SearchField()),
            Expanded(
                child: SizedBox(
              width: 5,
            )),
            // if(Responsive.isDesktop(context))ProfileCard(),
          ],
        ),
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
        initiallyExpanded: false,
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
          child:
              Consumer<FetchFireBaseData>(builder: (context, appState, child) {
            return GoogleProfilePic(appState: appState,);
              appState.adminUser == null
                ? GoogleProfilePic(appState: appState)
                : FutureBuilder<String>(
                    future: appState.getProfilePicture(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Row(
                          children: [
                            snapshot.data != null
                                ? Image.network(
                                    snapshot.data!,
                                    height: 38,
                                    errorBuilder: (context,_,__)=>GoogleProfilePic(appState: appState),
                                  )
                                : GoogleProfilePic(appState: appState),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: defaultPadding),
                              child: Text(appState.adminUser!.name),
                            ),
                          ],
                        );
                      }
                      return GoogleProfilePic(appState: appState);
                    },
                  );
          }),
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

class GoogleProfilePic extends StatelessWidget {
  final appState;
  const GoogleProfilePic({Key? key, required this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (appState.googleUserAccount != null)
        ? Row(
      children: [
        if (appState.googleUserAccount!.photoUrl != null)
          Image.network(
            appState.googleUserAccount!.photoUrl!,
            height: 38,
            errorBuilder: (context,_,__)=>CircularProgressIndicator(),
          ),
        if (!Responsive.isMobile(context))
          Padding(
            padding:
            const EdgeInsets.only(left: defaultPadding),
            child: Text(appState.googleUserAccount!.displayName),
          ),
      ],
    )
        : CircularProgressIndicator();
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
            // padding: EdgeInsets.all(defaultPadding * 0.75),
            // margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
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
