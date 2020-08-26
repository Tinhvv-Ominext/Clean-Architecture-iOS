#!/bin/sh

gen_view_controller() {
  local name=$1
  local name_lcamel=`echo $name | awk '{ print tolower(substr($0, 1, 1)) substr($0, 2, length($0) - 1) }'`
  local name_tmp=`echo $name_lcamel | sed -E 's/([A-Z])/_\1/g'`
  local name_snake=`echo $name_tmp | tr "[:upper:]" "[:lower:]"`

  local func_name=$2

  local file_path="../Base/Source/Presentasion/Controllers/${name}VC.swift"
  if [ ! -e $file_path ]; then
    sed -e "s/Xxx/${name}/g" -e "s/xxx/${name_snake}/g" -e "s/<functionname>/${func_name}/g" ./uigen_template/XxxVC.swift > $file_path
    echo "generated ${file_path}"
  fi

  file_path="../Base/Source/Presentasion/Presenter/${name}Presenter.swift"
  if [ ! -e $file_path ]; then
    sed -e "s/Xxx/${name}/g" -e "s/xxx/${name_snake}/g" -e "s/<functionname>/${func_name}/g" ./uigen_template/XxxPresenter.swift > $file_path
    echo "generated ${file_path}"
  fi

  file_path="../Base/Source/Presentasion/View/${name}View.swift"
  if [ ! -e $file_path ]; then
    sed -e "s/Xxx/${name}/g" -e "s/xxx/${name_snake}/g" -e "s/<functionname>/${func_name}/g" ./uigen_template/XxxView.swift > $file_path
    echo "generated ${file_path}"
  fi
}

cmd=""
name=""
funcName=""
to=""

while getopts vn:g:s: OPT
do
  case $OPT in
    "v" ) cmd="viewController" ;;
    "n" ) name=$OPTARG ;;
    "s" ) funcName=$OPTARG ;;
  esac
done

if [ $cmd = "viewController" ]; then
  gen_view_controller $name "${funcName}"
fi

echo "uigen completed"
 
exit
