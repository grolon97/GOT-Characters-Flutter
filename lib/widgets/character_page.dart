import 'package:flutter/material.dart';
import 'package:got_app/models/character.dart';
import 'package:got_app/themes/app_theme.dart' as theme;

class CharacterPage extends StatelessWidget {
  const CharacterPage({Key? key, required this.character}) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                    tag: 'dash',
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'FAVOURITE_DETAILS',
                            arguments: character);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: SizedBox(
                            height: 400,
                            width: 300,
                            child: Image.network(character.imageUrl,
                                fit: BoxFit.fill,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  return loadingProgress == null
                                      ? child
                                      : const Center(
                                          child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    const Text('Couldn\'t load the image'))),
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                ),
                Text(character.fullName, style: theme.headingTextStyle),
                Text(character.familyId.toString(), style: theme.headingTextStyle),
              ],
            )),
      ],
    );
  }
}
