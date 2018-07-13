import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:medium_app_ui/features/details/details_page.dart';
import 'package:medium_app_ui/features/main/main_page_reducer.dart';
import 'package:medium_app_ui/features/main/main_page_state.dart';
import 'package:medium_app_ui/shared/device_info.dart';
import 'package:medium_app_ui/shared/orientation_widget.dart';
import 'package:medium_app_ui/shared/state/app_state.dart';
import 'package:medium_app_ui/shared/ui/drawer.dart';
import 'package:medium_app_ui/shared/ui/menu_items.dart';

final _images = [
  Image.asset(
    "assets/cars.jpeg",
    fit: BoxFit.cover,
  ),
  Image.asset(
    "assets/gmail.jpeg",
    fit: BoxFit.cover,
  ),
  Image.asset(
    "assets/mars.jpeg",
    fit: BoxFit.cover,
  ),
  Image.asset(
    "assets/umbrella.jpeg",
    fit: BoxFit.cover,
  ),
];

class MainPage extends StatelessWidget {
  const MainPage();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "Home",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          backgroundColor: Colors.black,
          actions: [
            if (isWeb) ...menuItems,
            //if we are web spread the title bar with the drawer menu items
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Icon(
                Icons.notifications_none,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Icon(Icons.search, color: Colors.grey),
            ),
          ],
        ),
        body: StoreConnector<AppState, MainPageState>(
          onInit: (store) => store.dispatch(const FetchArticlesAction()),
          converter: (store) => store.state.mainPageState,
          builder: (context, mainPageState) {
            final hasError = mainPageState.error != null;
            final isLoading = mainPageState.isLoading;
            if (isLoading) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ),
              );
            } else {
              if (hasError) {
                return Container(
                  alignment: Alignment.center,
                  child: const Text('Something went wrong :('),
                );
              } else if (mainPageState.data == null ||
                  mainPageState.data.isEmpty) {
                return Container(
                  alignment: Alignment.center,
                  child: const Text('No items found'),
                );
              } else {
                return OrientationWidget(
                  primaryChild: ListView.builder(
                    itemBuilder: (context, position) {
                      Article article = mainPageState.data[position];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.category,
                                  style: TextStyle(
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 12.0, 0.0, 12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          article.title,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22.0),
                                        ),
                                        flex: 3,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          height: 80.0,
                                          width: 80.0,
                                          child: _images[position],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article.author,
                                          style: TextStyle(fontSize: 18.0),
                                        ),
                                        Text(
                                          article.date +
                                              " . " +
                                              article.readTime,
                                          style: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.bookmark_border),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: mainPageState.data.length,
                  ),
                  secondaryChild: const DetailsPage(),
                );
              }
            }
          },
        ),
        // we add the drawer only for mobile
        drawer: isWeb ? null : const MediumDrawer());
  }
}
