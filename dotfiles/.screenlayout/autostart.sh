#!/bin/bash

#ディスプレイの数を取得
DISPS=$(xrandr | grep " connected" | wc -l)

#if文の中で何も実行しないわけにはいかない
#if [ "$DISPS" -eq $1 ]; then
#  #ディスプレイが１つの場合
#fi

if [ "$DISPS" -eq 2 ]; then
  #ディスプレイが２つの場合
  #デュアルディスプレイ用のセッティングを読み込む
	bash "${HOME}/.screenlayout/dualdisplay.sh"
fi


#fehで壁紙の更新
#更新前にディスプレイの切り替え待ち
sleep 1
feh --bg-scale ~/.wallpapers/wallpaper
