part of 'portfolio_bloc.dart';

class PortfolioState extends Equatable {
  final bool isLoading;
  final PortfolioEntity? data;
  final String? error;

  const PortfolioState._({this.isLoading = false, this.data, this.error});

  const PortfolioState.loading() : this._(isLoading: true);

  const PortfolioState.success(PortfolioEntity data) : this._(data: data);

  const PortfolioState.failure(String error) : this._(error: error);

  @override
  List<Object?> get props => [isLoading, data, error];
}
