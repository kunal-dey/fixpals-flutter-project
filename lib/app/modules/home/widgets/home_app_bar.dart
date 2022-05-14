import 'package:fixpals/app/core/constants/palette.dart';
import 'package:fixpals/app/modules/home/widgets/search_sheet.dart';
import 'package:flutter/material.dart';

class HomePageAppBar extends StatelessWidget {
  final Function openDrawer;
  const HomePageAppBar({required this.openDrawer, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.22,
      decoration: const BoxDecoration(
        color: lightOrange,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Color(0xFF42BEA5),
            offset: Offset(-2, 0),
            spreadRadius: 3,
          )
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //Icon button to open the drawer
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: midnightGreen,
                    size: 25,
                  ),
                  onPressed: () {
                    print('IconButton pressed ...');
                    openDrawer();
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    color: midnightGreen,
                    size: 25,
                  ),
                  onPressed: () {
                    print('IconButton pressed ...');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 20),
            child: TextFormField(
              keyboardType: TextInputType.none,
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return makeDismissible(
                        context,
                        child: DraggableScrollableSheet(
                          initialChildSize: 0.9,
                          maxChildSize: 0.9,
                          builder: (_, controller) {
                            return SearchSheet();
                          },
                        ),
                      );
                    });
              },
              controller: textController,
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'Search any service',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsetsDirectional.fromSTEB(40, 20, 20, 20),
                suffixIcon: const Icon(
                  Icons.search_rounded,
                  color: dark,
                  size: 22,
                ),
              ),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }

  Widget makeDismissible(BuildContext context, {required Widget child}) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
}
