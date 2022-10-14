import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/family_cubit.dart';
import '../bloc/family_state.dart';
import '../widgets/family_list_view_item.dart';
import '../widgets/loading_message.dart';
import '../widgets/error_message.dart';

class AllFamiliesScreen extends StatelessWidget {
  const AllFamiliesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FamilyCubit, FamilyState>(builder: (context, state) {
      
      if (state is FamiliesLoading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            LoadingMessage(message: 'Fetching Favourites...'),
          ],
        );
      }

      if (state is FamiliesError) {
        print('FAMILIES ERROR');
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            ErrorMessage(message: 'An error has ocurred'),
          ],
        );
      }

      if (state is FamiliesLoaded) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: state.allFamilies.length,
          itemBuilder: (context, index) {
            // for padding and space purposes
            return FamilyListViewItem(family: state.allFamilies[index]);
          },
        );
      }

      return const Text('Families List');
    });
  }
}
