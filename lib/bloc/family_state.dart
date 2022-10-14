import 'package:equatable/equatable.dart';

import '../models/family.dart';

class FamilyState extends Equatable {
  final List<Family> allFamilies;
  final List<Family> favFamilies;

  const FamilyState(
      {this.allFamilies = const [], this.favFamilies = const []});

  @override
  List<Object> get props => allFamilies;

  FamilyState copyWith(
          {List<Family>? allFamilies, List<Family>? favFamilies}) =>
      FamilyState(
          allFamilies: allFamilies ?? this.allFamilies,
          favFamilies: favFamilies ?? this.favFamilies);
}

class FamiliesInitial extends FamilyState {}

class FamiliesLoading extends FamilyState {}

class FamiliesLoaded extends FamilyState {
  // must specify constructor when using named parameters
  const FamiliesLoaded(
      {required List<Family> allFamilies, required List<Family> favFamilies})
      : super(allFamilies: allFamilies, favFamilies: favFamilies);

  @override
  FamiliesLoaded copyWith(
          {List<Family>? allFamilies, List<Family>? favFamilies}) =>
      FamiliesLoaded(
          allFamilies: allFamilies ?? this.allFamilies,
          favFamilies: favFamilies ?? this.favFamilies);

  @override
  List<Object> get props => [identityHashCode(this)];
}

class FamiliesError extends FamilyState {}