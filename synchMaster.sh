#!/bin/sh

# 放到项目根目录下
# 执行 ./synchMaster.sh canary
# 再输入 y
# 即可重置本地及远程的canary分支 照此命令也可以清理其他分支

red="\033[31m"  # 红色
green="\033[32m"  # 绿色
reset="\033[0m"  # 重置设置

branch=$1

read -p "Are you sure to synch $branch branch with master?[y/n]" input

if [ $input != "y" ];then
  exit 0
fi

printf "\n$green start to synch ... $reset\n"

git checkout master && git pull origin master # 切到master分支并更新
git branch -D ${branch} && git push origin --delete ${branch} # 删除本地及远程分支
git checkout -b ${branch} && git push origin ${branch} -f # 从master新建分支并推到远程
git checkout master # 切回到master分支

if [ "$?" = 0 ]; then
  printf "\n$green $branch 分支同步master成功，现在是在master分支 $reset\n"
else
  printf "\n$red $branch 分支同步master失败，请手动同步 $reset\n"
fi