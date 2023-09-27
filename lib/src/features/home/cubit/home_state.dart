// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  final CardIDInfo? cardInfo;
  final NfcTag? nfcData;
  final bool isLoadingCallApi;
  final int countdown;
  final bool isLoadingDataNfc;

  const HomeState({
    this.cardInfo,
    this.nfcData,
    this.isLoadingCallApi = false,
    this.countdown = 30,
    this.isLoadingDataNfc = false,
  });

  @override
  List<Object?> get props => [
        cardInfo,
        nfcData,
        isLoadingCallApi,
        countdown,
        isLoadingDataNfc,
      ];

  HomeState copyWith({
    CardIDInfo? cardInfo,
    NfcTag? nfcData,
    bool? isLoadingCallApi,
    int? countdown,
    bool? isLoadingDataNfc,
  }) {
    return HomeState(
      cardInfo: cardInfo ?? this.cardInfo,
      nfcData: nfcData ?? this.nfcData,
      isLoadingCallApi: isLoadingCallApi ?? this.isLoadingCallApi,
      countdown: countdown ?? this.countdown,
      isLoadingDataNfc: isLoadingDataNfc ?? this.isLoadingDataNfc,
    );
  }
}
