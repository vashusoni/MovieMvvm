import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_hub/app/data/response/status.dart';
import 'package:movie_hub/app/models/movie_model.dart';
import 'package:movie_hub/app/repository/movie_list_repository.dart';
import 'package:movie_hub/app/utils/utils.dart';
import 'package:movie_hub/app/view/screen/movie_deatils.dart';
import 'package:movie_hub/app/view_model/movie_view_model.dart';
import 'package:provider/provider.dart';

import '../widgets/brows_widget.dart';
import '../widgets/movie_name_widget.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final movieController = TextEditingController();

  @override
  void initState() {
   intMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Consumer<MovieViewModel>(builder: (context, provider, child) {
            return Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BrowsWidget(),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30),
                            ],
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                provider.setValue(value, context);

                                return;
                              }
                              provider.setValue("dead", context);
                              return;
                            },
                            keyboardType: TextInputType.text,
                            controller: movieController,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: "Search Movie",
                              fillColor: Colors.grey,
                              filled: true,
                              prefixIcon: const Icon(
                                CupertinoIcons.search,
                                color: Colors.white,
                              ),
                              focusColor: Colors.grey,
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))),
                Expanded(
                  flex: 8,
                  child: Consumer<MovieViewModel>(
                    builder: (context, value, child) {
                      switch (value.movieList.status) {
                        case Status.LOADING:
                          return const Center(
                              child: CircularProgressIndicator());
                        case Status.ERROR:
                          return const Center(
                              child: Text(
                          "Please write movie",
                            style: TextStyle(color: Colors.white),
                          ));
                        case Status.COMPLETED:
                          return Center(
                            child: GridView.builder(
                              itemCount: value.movieList.data!.search.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 4 / 7,
                                      crossAxisSpacing: 2,
                                      mainAxisSpacing: 2,
                                      crossAxisCount: 3),
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailsView(
                                                    id: value
                                                        .movieList
                                                        .data!
                                                        .search[index]
                                                        .imdbId)));
                                  },
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          value.movieList.data!.search[index]
                                              .poster,
                                          height: 150.0,
                                          width: 100.0,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MovieNameWidget(
                                              name: value.movieList.data!
                                                  .search[index].title),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            value.movieList.data!.search[index]
                                                .year,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 13),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        default:
                          return Container();
                      }
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  void intMethod() {
    final provider = Provider.of<MovieViewModel>(context, listen: false);
    provider.searchMovie(context);
  }
}
