import 'package:equatable/equatable.dart';
import 'package:got_app/models/character.dart';

class CharacterState extends Equatable {
  final List<Character> allCharacters;
  final List<Character> favCharacters;

  const CharacterState(
      {this.allCharacters = const [], this.favCharacters = const []});

  @override
  List<Object> get props => allCharacters;

  CharacterState copyWith(
          {List<Character>? allCharacters, List<Character>? favCharacters}) =>
      CharacterState(
          allCharacters: allCharacters ?? this.allCharacters,
          favCharacters: favCharacters ?? this.favCharacters);
}

class CharactersInitial extends CharacterState {}

class CharactersLoading extends CharacterState {}

class CharactersLoaded extends CharacterState {
  // must specify constructor when using named parameters
  const CharactersLoaded(
      {required List<Character> allCharacters, required List<Character> favCharacters})
      : super(allCharacters: allCharacters, favCharacters: favCharacters);

  @override
  CharactersLoaded copyWith(
          {List<Character>? allCharacters, List<Character>? favCharacters}) =>
      CharactersLoaded(
          allCharacters: allCharacters ?? this.allCharacters,
          favCharacters: favCharacters ?? this.favCharacters);

  @override
  List<Object> get props => [identityHashCode(this)];
}

class CharactersError extends CharacterState {}
