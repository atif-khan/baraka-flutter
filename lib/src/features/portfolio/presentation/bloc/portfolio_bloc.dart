import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/portfolio.dart';
import '../../domain/usecases/get_portfolio.dart';

part 'portfolio_event.dart';
part 'portfolio_state.dart';

@injectable
class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  final GetPortfolioUseCase getPortfolio;

  PortfolioBloc(this.getPortfolio) : super(const PortfolioState.loading()) {
    on<PortfolioRequested>(_onPortfolioRequested);
  }

  Future<void> _onPortfolioRequested(
    PortfolioRequested event,
    Emitter<PortfolioState> emit,
  ) async {
    emit(const PortfolioState.loading());
    try {
      final data = await getPortfolio();
      emit(PortfolioState.success(data));
    } catch (e) {
      emit(PortfolioState.failure(e.toString()));
    }
  }
}
