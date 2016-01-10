#!/bin/bash
if [ $1 == "-h" ];then 
	echo "Help information:"
	echo "Example:  ./easybundle.sh  jsbundles/xx/home.js , before use it you should chmod 777 ./easybundle.sh"
	echo "If you want to set more parameters , you need to modify this script "
	exit 0
fi
THIS_DIR=$(dirname "$0")
INPUTJS=$THIS_DIR/$1
JSTMP=$1
echo "Current path is $THIS_DIR"
echo "Input main js path is $INPUTJS"
DEST=$THIS_DIR/outputBundle
#echo "Output bundle destination path is $DEST" 
if [ -z "$1" ]
then
	echo "no input main js file , exit!!!"
	exit 1
else
	#echo "input main js file path is $1"
	INPUTJS=$THIS_DIR/$1
fi
if [ -d "$DEST" ]
then 
    echo "Output bundle directory is $DEST"
else
	echo "Create new output directory $DEST" 
	mkdir $DEST
fi
JS_PLUGIN_NAME1=`echo $JSTMP| cut -d "/" -f 2`
JS_PLUGIN_NAME=$JS_PLUGIN_NAME1.android.jsbundle
echo "Automaticlly generate output bundle name $JS_PLUGIN_NAME"
echo "Removing old output bundle file ......"
rm -f $DEST/$JS_PLUGIN_NAME
echo -e “======================Start generating bundle======================” 
node "$THIS_DIR/local-cli/cli.js" \
bundle --entry-file \
$INPUTJS --platform android --dev false  --bundle-output  $DEST/$JS_PLUGIN_NAME
echo -e “======================End generating bundle======================” 
if [ -f "$DEST/$JS_PLUGIN_NAME" ]
then
    echo -e “generating bundle successfully, plz see it in $DEST ” 
    #echo "generating bundle successfully, plz see it in $DEST"
else
	echo -e “generate bundle file failed , will exit!!!” 
    exit 1
fi
exit 0