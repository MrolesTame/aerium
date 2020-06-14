import 'package:flutter/material.dart';
import 'package:portfoliosite/core/layout/adaptive.dart';
import 'package:portfoliosite/core/utils/functions.dart';
import 'package:portfoliosite/presentation/widgets/spaces.dart';
import 'package:portfoliosite/presentation/widgets/tree_painter.dart';
import 'package:portfoliosite/values/values.dart';
import 'package:universal_html/html.dart';

class ExperienceTree extends StatelessWidget {
  ExperienceTree({
    @required this.experienceData,
    this.head,
    this.widthOfTree,
    this.headTitle,
    this.headTitleStyle,
    this.tailTitleStyle,
    this.tail,
    this.tailTitle,
    this.headBackgroundColor = AppColors.cream700,
    this.tailBackgroundColor = AppColors.cream700,
    this.scrollController,
  });

  final Widget head;
  final double widthOfTree;
  final String headTitle;
  final TextStyle headTitleStyle;
  final TextStyle tailTitleStyle;
  final Color headBackgroundColor;
  final String tailTitle;
  final Color tailBackgroundColor;
  final Widget tail;
  final List<ExperienceData> experienceData;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      child: ListView(
        controller: scrollController,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(Sizes.PADDING_8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.RADIUS_16),
                color: headBackgroundColor,
              ),
              child: Text(
                headTitle,
                style: headTitleStyle ?? theme.textTheme.subtitle1.copyWith(),
              ),
            ),
          ),
          Column(
            children: _buildExperienceBranches(experienceData),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(Sizes.PADDING_8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.RADIUS_16),
                color: tailBackgroundColor,
              ),
              child: Text(
                tailTitle,
                style: tailTitleStyle ?? theme.textTheme.subtitle1.copyWith(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildExperienceBranches(List<ExperienceData> experienceData) {
    List<Widget> branchWidgets = [];
    for (var index = 0; index < experienceData.length; index++) {
      branchWidgets.add(ExperienceBranch(
        company: experienceData[index].company,
        companyUrl: experienceData[index].companyUrl,
        position: experienceData[index].position,
        role: experienceData[index].role,
        location: experienceData[index].location,
        duration: experienceData[index].duration,
        width: widthOfTree,
      ));
    }

    return branchWidgets;
  }
//  List<Widget> _buildRoles(List<String> roles) {

//  }
}

class ExperienceBranch extends StatelessWidget {
  ExperienceBranch({
    this.width,
    this.height = 200,
    this.role,
    this.company,
    this.companyUrl,
    this.position,
    this.location,
    this.duration,
    this.customPainter,
    this.stalk = 0.1,
  });

  final double width;
  final double stalk;
  final double height;
  final String company;
  final String companyUrl;
  final String location;
  final String duration;
  final String position;
  final String role;
  final CustomPainter customPainter;

  @override
  Widget build(BuildContext context) {
//    print("Halfwidth:: ${width / 2}  width:: ${width}");
    return CustomPaint(
      foregroundPainter: customPainter ??
          TreePainter(
            stalk: 0.1,
//            veinsColor: Color(0xFFDDDAE5),
//            outerJointColor: Color(0xFFDDDAE5),
//            innerJointColor: Color(0xFF5325A8),
          ),
      child: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            Positioned(
              width: width / 2,
              height: height,
              top: (height / 2) - 10,
              left: 0,
              child: Container(
                padding: EdgeInsets.only(right: (width * stalk)),
                child: LocationDateLeaf(
                  duration: duration,
                  location: location,
                ),
              ),
            ),
            SpaceH8(),
            Positioned(
              width: width / 2,
              height: height,
              top: (height / 2) - 10,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(left: (width * stalk)),
                child: RoleLeaf(
                  company: company,
                  onTap: () {
                    Functions.launchUrl(companyUrl);
                  },
                  position: position,
                  role: role,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LocationDateLeaf extends StatelessWidget {
  LocationDateLeaf({
    @required this.duration,
    @required this.location,
    @required this.durationIcon,
    @required this.locationIcon,
    this.locationTextStyle,
    this.durationTextStyle,
  });

  final String duration;
  final TextStyle durationTextStyle;
  final String location;
  final TextStyle locationTextStyle;
  final Icon locationIcon;
  final Icon durationIcon;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                duration,
                style:
                    durationTextStyle ?? theme.textTheme.bodyText2.copyWith(),
              ),
              SpaceW4(),
              Icon(
                Icons.access_time,
                color: AppColors.deepBlue800,
                size: 18,
              ),
            ],
          ),
          SpaceH8(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                location,
                style:
                    locationTextStyle ?? theme.textTheme.bodyText2.copyWith(),
              ),
              SpaceW4(),
              Icon(
                Icons.location_on,
                color: AppColors.deepBlue800,
                size: 18,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class RoleLeaf extends StatelessWidget {
  RoleLeaf({
    @required this.company,
    @required this.position,
    @required this.role,
    this.companyTextStyle,
    this.positionTextStyle,
    this.roleTextStyle,
    this.onTap,
  });

  final String company;
  final String position;
  final String role;
  final TextStyle companyTextStyle;
  final TextStyle positionTextStyle;
  final TextStyle roleTextStyle;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: onTap,
            child: Text(
              company,
              style: companyTextStyle ??
                  theme.textTheme.subtitle1.copyWith(
                    fontSize: Sizes.TEXT_SIZE_18,
                  ),
            ),
          ),
          Text(
            position,
            style: positionTextStyle ??
                theme.textTheme.subtitle2.copyWith(
                  fontStyle: FontStyle.italic,
                ),
          ),
          SpaceH8(),
          Text(
            role,
            style: positionTextStyle ?? theme.textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
