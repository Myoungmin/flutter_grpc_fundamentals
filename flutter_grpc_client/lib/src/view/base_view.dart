import 'package:flutter/material.dart';
import 'package:flutter_grpc_client/src/view/base_view_model.dart';
import 'package:flutter_grpc_client/theme/component/circular_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseView<VM extends BaseViewModel<S>, S extends BaseViewState>
    extends ConsumerWidget {
  const BaseView({
    super.key,
    required this.viewModelProvider,
    required this.builder,
  });

  final AutoDisposeNotifierProvider<VM, S> viewModelProvider;
  final Widget Function(WidgetRef ref, VM viewModel, S state) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(viewModelProvider);
    return CircularIndicator(
      isBusy: state.isBusy,
      child: builder(
        ref,
        ref.read(viewModelProvider.notifier),
        state,
      ),
    );
  }
}
