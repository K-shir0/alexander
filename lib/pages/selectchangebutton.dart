import 'package:alexander/pages/theme/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectChangeButton extends StatelessWidget {
  const SelectChangeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 56, top: 25),
      child: Row(
        children: [
          //マンダラ
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Column(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.borderColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    //マンダラボタンクリックイベント
                    onTap: () {},
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'マンダラ',
                    style:
                        TextStyle(fontSize: 12, color: Palette.accentTextColor),
                  ),
                )
              ],
            ),
          ),
          //履歴
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Column(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.borderColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    //履歴ボタンのクリックイベント
                    onTap: () {},
                    child: const Icon(
                      Icons.access_time,
                      color: Palette.accentTextColor,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    '履歴',
                    style:
                        TextStyle(fontSize: 12, color: Palette.accentTextColor),
                  ),
                )
              ],
            ),
          ),
          //ミックス
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Column(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.borderColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    //ミックスボタンクリックイベント
                    onTap: () {},
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'ミックス',
                    style:
                        TextStyle(fontSize: 12, color: Palette.accentTextColor),
                  ),
                )
              ],
            ),
          ),
          //消去
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Column(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    border: Border.all(color: Palette.borderColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    //消去ボタンクリックイベント
                    onTap: () {},
                    child: const Icon(
                      Icons.delete_outline,
                      color: Palette.accentTextColor,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    '消去',
                    style:
                        TextStyle(fontSize: 12, color: Palette.accentTextColor),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
