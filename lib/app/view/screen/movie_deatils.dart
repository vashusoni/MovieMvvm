import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_hub/app/view/screen/movie_list_view.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';
import '../../view_model/movie_view_model.dart';

class MovieDetailsView extends StatefulWidget {
  const MovieDetailsView({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<MovieDetailsView> createState() => _MovieDetailsViewState();
}

class _MovieDetailsViewState extends State<MovieDetailsView> {
  @override
  void initState() {
    final provider = Provider.of<MovieViewModel>(context, listen: false);
    provider.searchMovieDetails(widget.id, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MovieList()),
          (route) => false);
      return false;
    }, child: Scaffold(body: SafeArea(
      child: Consumer<MovieViewModel>(
        builder: (context, value, child) {
          switch (value.movieDetails.status) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(
                  child: Text(
                value.movieDetails.message.toString(),
                style: const TextStyle(color: Colors.white),
              ));
            case Status.COMPLETED:
              return Center(
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SizedBox(
                        height: 600,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            value.movieDetails.data!.poster,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 20,
                        right: 20,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.8),
                              borderRadius: BorderRadius.circular(15)),
                          height: 500,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    value.movieDetails.data!.title,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.star,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        Text(value.movieDetails.data!.imdbVotes,
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.clock,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        Text(
                                          value.movieDetails.data!.runtime,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.movieDetails.data!.genre,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                ),
                                SizedBox(
                                    height: 100,
                                    child: Text(
                                      value.movieDetails.data!.plot,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          height: 1.6),
                                    )),
                                Text(
                                  "Director: ${value.movieDetails.data!.director}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                    height: 100,
                                    child: Text(
                                      value.movieDetails.data!.plot,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          height: 1.6),
                                    )),
                                SizedBox(
                                    height: 40,
                                    child: Text(
                                      "WRITER: ${value.movieDetails.data!.writer}",
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          height: 1.6),
                                    )),
                                SizedBox(
                                    height: 40,
                                    child: Text(
                                      "ACTOR: ${value.movieDetails.data!.actors}",
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          height: 1.6),
                                    )),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              );
            default:
              return Container();
          }
        },
      ),
    )));
  }
}
