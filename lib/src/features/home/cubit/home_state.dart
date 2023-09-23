// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  final CardIDInfo? cardInfo;
  final NfcTag? nfcData;
  const HomeState({
    this.cardInfo,
    this.nfcData,
  });

  @override
  List<Object?> get props => [
        cardInfo,
        nfcData,
      ];

  HomeState copyWith({
    CardIDInfo? cardInfo,
    NfcTag? nfcData,
  }) {
    return HomeState(
      cardInfo: cardInfo ?? this.cardInfo,
      nfcData: nfcData ?? this.nfcData,
    );
  }
}
