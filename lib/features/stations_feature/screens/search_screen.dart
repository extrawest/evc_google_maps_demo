import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/features/stations_feature/bloc/bloc.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/search_bar.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/search_query_item.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stationBloc = context.watch<StationsBloc>();
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const Hero(
                  tag: 'SearchBar',
                  child: Material(
                    child: SearchBarWidget(
                      autofocus: true,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (stationBloc.state.searchQuery.isEmpty &&
                    stationBloc.state.recentSearches.isNotEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Recent searches',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                BlocBuilder<StationsBloc, StationsState>(
                  builder: (context, state) {
                    if (state.searchQuery.isEmpty) {
                      if (state.recentSearches.isEmpty) {
                        return const Text('Type something to search');
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.recentSearches.length,
                            itemBuilder: (context, index) {
                              return SearchQueryItem(state.recentSearches[index]);
                            },
                          ),
                        );
                      }
                    } else {
                      final queriedStations = state.stations
                          .where((element) =>
                              element.stationId.startsWith(state.searchQuery))
                          .toList();
                      return queriedStations.isEmpty
                          ? const Text('No results')
                          : Expanded(
                              child: ListView.builder(
                                itemCount: queriedStations.length,
                                itemBuilder: (context, index) {
                                  return SearchQueryItem(queriedStations[index]);
                                },
                              ),
                            );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
