part of '../core.dart';

extension GetItExtension on GetIt {
  DioInstances get dio => DioInstances();
}

class DioInstances {
  Dio get accu => GetIt.I<Dio>(instanceName: 'accuwather');
}
