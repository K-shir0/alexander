import 'package:alexander/domain/idea.dart';
import 'package:alexander/domain/operation.dart';
import 'package:alexander/domain/space.dart';
import 'package:alexander/domain/transaction.dart';
import 'package:alexander/service/base/client.dart';
import 'package:alexander/service/model/space.dart';
import 'package:alexander/service/space.dart';
import 'package:alexander/view_model/model/home_page_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:uuid/uuid.dart';

final homePageProvider =
    StateNotifierProvider.autoDispose<HomePageStateNotifier, HomePageState>(
        (ref) => HomePageStateNotifier(const HomePageState(), ref));

class HomePageStateNotifier extends StateNotifier<HomePageState>
    with LocatorMixin {
  HomePageStateNotifier(HomePageState state, this.ref) : super(state);

  final ProviderReference ref;

  /**
   *
   * Initialize
   *
   */

  /// 初期化処理
  Future<void> initialize(BuildContext context, String spaceId) async {
    fetchPage(spaceId);
  }

  /**
   *
   * on Action
   *
   */

  /// スペースを追加するボタンの処理
  Function() onTapAddSpace() => () {
        final spaceId = const Uuid().v4();

        // スペースを追加する処理
        final spaces = [...state.spaces];
        spaces.add(SpaceMetadata(id: spaceId));
        state = state.copyWith(spaces: spaces);

        // 通知
        ref.read(spaceProvider).setSpace(SetSpaceRequest(id: spaceId));
      };

  /// アイデアでエンターボタンを押した時の処理
  Function() onEnterKeyAction(String currentSpaceId, String currentIdeaId) =>
      () {
        final ideas = state.ideas;

        final newIdea = Idea(id: const Uuid().v4());

        // 現在の配列番号を取得
        final index =
            ideas.indexWhere((element) => element.id == currentIdeaId);

        if (index != -1) {
          ideas.insert(index + 1, newIdea);

          // 状態を反映
          state = state.copyWith(ideas: ideas);

          // トランザクションを作成
          // if (state.transactions.isEmpty) {
          var transaction =
              Transaction(id: const Uuid().v4(), spaceId: currentSpaceId);

          transaction = transaction.copyWith(operations: [
            Operation(
                id: const Uuid().v4(),
                command: 'next',
                args: [newIdea.id, currentIdeaId])
          ]);

          state = state.copyWith(transactions: [transaction]);

          if (!state.isSaving) {
            print(state.transactions);

            state = state.copyWith(isSaving: true);

            ref
                .read(spaceProvider)
                .savePage(SavePageRequest(transactions: state.transactions))
            // 失敗したらtmpから戻す
                .whenComplete(
                  () => state = state.copyWith(isSaving: false),
                );

            state = state.copyWith(transactions: []);
          }
          // }

          print(state.transactions);

          return;
        }

        // TODO 無ければ追加
      };

  /// アイデアでデリートキーを押した時の処理
  Function() onDeleteKeyAction() => () {};

  /**
   *
   *  Fetch
   *
   */

  /// スペースの一覧を取得する処理
  Future<void> fetchSpace(BuildContext context) async {
    await ref.read(spaceProvider).getSpace().then((value) => value.when(
          success: (_) {
            state = state.copyWith(spaces: _.data.spaces);

            AutoRouter.of(context)
                .pushNamed('/test/home/${state.spaces.first.id}');
          },
          failure: (_) {},
        ));
  }

  /// アイデア一覧（ページ）を取得する処理
  Future<void> fetchPage(String id) async {
    await ref
        .read(spaceProvider)
        .getPage(GetPageRequest(id: id))
        .then((value) => value.when(
              success: (_) {
                final ideas = _.data.copyWith().ideas;

                // アイデアをソート
                ideas.sort((idea1, idea2) {
                  if (idea1.position > idea2.position) {
                    return 1;
                  } else {
                    return -1;
                  }
                });

                state = state.copyWith(ideas: ideas);
              },
              failure: (_) {},
            ));
  }
}
