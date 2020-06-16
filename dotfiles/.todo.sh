#!/usr/bin/env bash


if [ ! -d /D/memo ]; then
	 #no disk /D at all
  exit
fi

if [ ! -d ~/memo ]; then
	 #create link
		ln -sfn /D/memo ~/memo
fi

#launch
exec rxvt -e bash -i -c "nvim ~/memo/todo"
