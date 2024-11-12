import 'package:bloc_learner/bloc/favorite_app/favorite_app_bloc.dart';
import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:bloc_learner/widgets/app_bar_delete_button.dart';
import 'package:bloc_learner/widgets/custom_check_box.dart';
import 'package:bloc_learner/widgets/custom_animations/loading/loading_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteAppScreen extends StatefulWidget {
  const FavoriteAppScreen({super.key});

  @override
  State<FavoriteAppScreen> createState() => _FavoriteAppScreenState();
}

class _FavoriteAppScreenState extends State<FavoriteAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite apps'),
        actions: [
          // refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<FavoriteAppBloc>().add(FetchFavoriteApp());
            },
          ),

          // get list apps filter by isDeleting = true
          // if (context
          //     .select((FavoriteAppBloc bloc) =>
          //         bloc.state.apps.where((app) => app.isDeleting).toList())
          //     .isNotEmpty)
          BlocBuilder<FavoriteAppBloc, FavoriteAppState>(
            builder: (context, state) {
              final deletingApps =
                  state.apps.where((app) => app.isDeleting).toList();
              if (deletingApps.isNotEmpty) {
                return AppBarDeleteButton(
                  length: deletingApps.length,
                  onPressed: () {
                    context.read<FavoriteAppBloc>().add(
                          RemoveFavorite(removeApps: deletingApps),
                        );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      body: CupertinoScrollbar(
        thickness: 8,
        radius: const Radius.circular(15),
        child: BlocBuilder<FavoriteAppBloc, FavoriteAppState>(
          builder: (context, state) {
            switch (state.status) {
              case ListStatus.loading:
                return LoadingBox.jumpingDots(hasBackground: true);
              case ListStatus.success:
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    itemCount: state.apps.length,
                    itemBuilder: (context, index) {
                      final item = state.apps[index];
                      return Padding(
                        padding: index == 0
                            ? const EdgeInsets.only(top: 8)
                            : const EdgeInsets.only(top: 0),
                        child: Card(
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onTap: () {
                              context.read<FavoriteAppBloc>().add(
                                    DeletingFavorite(app: item),
                                  );
                            },
                            child: ListTile(
                              title: Text(item.name),
                              titleTextStyle: TextStyle(
                                  fontFamily: GoogleFonts.lexend().fontFamily,
                                  fontSize: 14,
                                  decoration: item.isDeleting
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  fontStyle: item.isDeleting
                                      ? FontStyle.italic
                                      : FontStyle.normal,
                                  color: DarkMode.getForegroundColor(context)),
                              leading: CustomCheckBox(
                                value: item.isDeleting,
                                onChanged: (bool? value) {
                                  setState(() {
                                    context
                                        .read<FavoriteAppBloc>()
                                        .add(DeletingFavorite(app: item));
                                  });
                                },
                              ),
                              trailing: Theme(
                                data: ThemeData(
                                  splashFactory: NoSplash.splashFactory,
                                ),
                                child: IconButton(
                                  icon: item.isFavorite
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : const Icon(Icons.favorite_border),
                                  onPressed: () {
                                    context.read<FavoriteAppBloc>().add(
                                          AddFavorite(app: item),
                                        );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              case ListStatus.failure:
                return const Center(
                  child: Text('Failed to fetch apps'),
                );
            }
          },
        ),
      ),
    );
  }
}
