import 'package:equatable/equatable.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitState extends NewsState {}
class LoadingState extends NewsState {}

class SuccessState extends NewsState {
  final dynamic data;
  SuccessState({required this.data});
}

class ErrorState extends NewsState {
  final String message;
  ErrorState({required this.message});
}