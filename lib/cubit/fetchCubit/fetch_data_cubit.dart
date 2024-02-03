import 'package:bloc/bloc.dart';
import 'package:finance/models/finance_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'fetch_data_state.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  FetchDataCubit() : super(FetchDataInitial());
  List<FinanceModel> financeList = [];
  List<FinanceModel> dateFinanceList = [];
  List<FinanceModel> todayFinanceList = [];
  double sum = 0.0;
  DateTime sel = DateTime.now();
  double todaySum = 0.0;
  fetchData() {
    emit(FetchDataLoading());
    try {
      financeList = Hive.box<FinanceModel>('financeBox').values.toList();
      todayFinanceList = financeList
          .where((element) =>
              DateFormat.yMMMEd().format(element.date) ==
              DateFormat.yMMMEd().format(DateTime.now()))
          .toList();
      fetchDateData(dateTime: sel);
      sum = 0;
      todaySum = 0;
      for (var element in financeList) {
        sum += element.financeValue;
      }
      for (var element in todayFinanceList) {
        todaySum += element.financeValue;
      }
      emit(FetchDataSuccess());
    } on Exception catch (e) {
      emit(FetchDataFailur(e.toString()));
    }

    return financeList;
  }

  fetchDateData({DateTime? dateTime}) {
    dateFinanceList = financeList
        .where((element) =>
            DateFormat.yMMMEd().format(element.date) ==
            DateFormat.yMMMEd().format(dateTime ?? DateTime.now()))
        .toList();
  }
}
