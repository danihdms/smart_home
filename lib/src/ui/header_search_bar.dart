import 'package:flutter/material.dart';
import 'constants.dart';

class HeaderSearchBar extends StatelessWidget {
  const HeaderSearchBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: kDefaultPadding * 2.5),
        height: size.height * 0.15,
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                left: kDefaultPadding,
                bottom: 36 + kDefaultPadding,
              ),
              height: size.height * 0.15 - 27,
              decoration: const BoxDecoration(
                color: kBrown,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: Center(
                child: Text(
                  'Smart Home',
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: kWhite,
                      ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 45,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 10),
                      blurRadius: 50,
                      color: kLightSteelBlue.withOpacity(0.23),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: kBrown.withOpacity(0.5),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffixIconConstraints: const BoxConstraints(maxHeight: 24),
                    suffixIcon: Image.asset('assets/search_icon.png'),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
