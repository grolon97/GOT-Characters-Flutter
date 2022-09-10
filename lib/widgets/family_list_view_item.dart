import 'package:flutter/material.dart';
import 'package:got_app/models/family.dart';
import 'package:got_app/bloc/family_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FamilyListViewItem extends StatelessWidget {
  final Family family;

  const FamilyListViewItem({Key? key, required this.family}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FamilyCubit familyCubit = context.read<FamilyCubit>();
    return Container(
      padding: const EdgeInsets.fromLTRB(7.5, 10, 7.5, 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
                flex: 1,
                child: Center(
                    child: IconButton(
                  icon: familyCubit.checkFavourite(family)
                      ? const Icon(Icons.favorite_sharp,
                          color: Colors.redAccent)
                      : const Icon(Icons.favorite_border_outlined),
                  onPressed: () {},
                ))),
            Flexible(
              flex: 4,
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: GestureDetector(
                    child: Text(family.name),
                    onTap: () {
                      Navigator.pushNamed(context, 'FAMILY_CHARACTERS',
                          arguments: family);
                    },
                  )),
            ),
            Flexible(
              flex: 2,
              child: Center(
                  child: CircleAvatar(
                      backgroundColor: Colors.blue[500],
                      child: Text(family.characterCount.toString(),
                          style: const TextStyle(color: Colors.white)))),
            ),
          ]),
    );
  }
}
