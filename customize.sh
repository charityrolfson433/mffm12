## MFFM v12 Private by MFFM
## 2023.12.30

#Debugging mode enabled
set -xv

[ -d ${ORIDIR:=`magisk --path`/.magisk/mirror} ] || \ # Borrowed From OMF
    ORIDIR=
[ -d ${ORIPRD:=$ORIDIR/product} ] || \ # Borrowed From OMF
    ORIPRD=$ORIDIR/system/product
[ -d ${ORISYSEXT:=$ORIDIR/system_ext} ] || \ # Borrowed From OMF
    ORISYSEXT=$ORIDIR/system/system_ext

#Original Paths
ORIPRDFONT=$ORIPRD/fonts
ORIPRDETC=$ORIPRD/etc
#ORIPRDXML=$ORIPRDETC/fonts_customization.xml
ORIPRDXML=/sdcard/MFFM/fontsxml/fonts_customization.xml
ORISYSFONT=$ORIDIR/system/fonts
ORISYSETC=$ORIDIR/system/etc
#ORISYSXML=$ORISYSETC/fonts.xml
ORISYSXML=/sdcard/MFFM/fontsxml/fonts.xml

#MODPATH
PRDFONT="$MODPATH/$(if [ -L "/system/product" ]; then echo "system/product"; else echo "product"; fi)/fonts"
PRDETC="$MODPATH/$(if [ -L "/system/product" ]; then echo "system/product"; else echo "product"; fi)/etc"
PRDXML=$PRDETC/fonts_customization.xml
SYSFONT=$MODPATH/system/fonts
SYSETC=$MODPATH/system/etc
SYSEXTETC="$MODPATH/$(if [ -L "/system/system_ext" ]; then echo "system/system_ext"; else echo "system_ext"; fi)/etc"
SYSXML=$SYSETC/fonts.xml
MODPROP=$MODPATH/module.prop
FONTDIR=$MODPATH/Files
#MFFM
MFFM=/sdcard/MFFM
[ ! -d $MFFM ] && mkdir -p $MFFM
#API
APILEVEL=$(getprop ro.build.version.sdk)

# Creating / Copying directories and files
mv $FONTDIR/bin $MODPATH/bin
base64 -d $MODPATH/bin > $MODPATH/f && tar xf $MODPATH/f -C $MODPATH
mkdir -p $PRDFONT $PRDETC $SYSFONT $SYSETC $SYSEXTETC

if [ ! -f "$ORISYSXML" ]; then    
    nohup am start -a android.intent.action.VIEW -d https://telegra.ph/Installation-Logic-for-seamless-installing-updating-12-28 >/dev/null 2>&1 &
    exit 1
else    
    cp "$ORISYSXML" "$SYSXML"
fi
[ -f $ORIPRDXML ] && cp $ORIPRDXML $PRDXML

grep -q 'miui' $SYSXML && {
  echo "- Miui detected, Not supported, Aborting installation."  
  exit 1
}

mffmex(){
    sleep 1
	ui_print ""
	ui_print "- Copying MFFM folder resources to module directory."
	if [ -n "$(find "$FONTDIR" -maxdepth 1 -type f \( -name "*.zip" -o -name "*.ttf" \) -name "Beng*")" ]; then
        :
    else
        bengali=$(find "$MFFM" -maxdepth 1 -type f \( -name "*.zip" -o -name "*.ttf" \) -name "Beng*")    
        if [ -n "$bengali" ]; then
            cp $bengali $FONTDIR
        fi
    fi	
	if [ -n "$(find "$FONTDIR" -maxdepth 1 -type f \( -name "*.zip" -o -name "*.ttf" \) -name "Serif*")" ]; then
        :
    else
        serif=$(find "$MFFM" -maxdepth 1 -type f \( -name "*.zip" -o -name "*.ttf" \) -name "Serif*")    
        if [ -n "$serif" ]; then
            cp $serif $FONTDIR
        fi
    fi	
	if [ -n "$(find "$FONTDIR" -maxdepth 1 -type f -name "Mono*.ttf")" ]; then
       :
    else
        monofile=$(find "$MFFM" -maxdepth 1 -type f -name "Mono*.ttf")    
        if [ -n "$monofile" ]; then
            cp $monofile $FONTDIR
        fi
    fi
}

    F1="Roboto-Regular.ttf" F2="GoogleSans-Regular.ttf" F3="GoogleSans-Italic.ttf"
    SS="<family name=\"sans-serif\">" SSC="<family name=\"sans-serif-condensed\">" VRD="<alias name=\"verdana\" to=\"sans-serif\" \/>" GSN="<family customizationType=\"new-named-family\" name=\"googlesans\">"
	GS="<family customizationType=\"new-named-family\" name=\"google-sans\">" GST="<family customizationType=\"new-named-family\" name=\"google-sans-text\">" GSB="<family customizationType=\"new-named-family\" name=\"google-sans-bold\">"
	GSM="<family customizationType=\"new-named-family\" name=\"google-sans-medium\">" GSTM="<family customizationType=\"new-named-family\" name=\"google-sans-text-medium\">" GSTB="<family customizationType=\"new-named-family\" name=\"google-sans-text-bold\">"
	GSTBI="<family customizationType=\"new-named-family\" name=\"google-sans-text-bold-italic\">" GSTMI="<family customizationType=\"new-named-family\" name=\"google-sans-text-medium-italic\">" GSTI="<family customizationType=\"new-named-family\" name=\"google-sans-text-italic\">"

    #INDEX
    t=0 ti=1 l=2 li=3 r=4 ri=5 m=6 mi=7 b=8 bi=9 bl=10 bli=11

	#S
	thin="<font weight=\"100\" style=\"normal\" index=\"$t\">$F1<\/font>"	thinitalic="<font weight=\"100\" style=\"italic\" index=\"$ti\">$F1<\/font>"
	light="<font weight=\"300\" style=\"normal\" index=\"$l\">$F1<\/font>"	lightitalic="<font weight=\"300\" style=\"italic\" index=\"$li\">$F1<\/font>"
	regular="<font weight=\"400\" style=\"normal\" index=\"$r\">$F1<\/font>"	italic="<font weight=\"400\" style=\"italic\" index=\"$ri\">$F1<\/font>"
	medium="<font weight=\"500\" style=\"normal\" index=\"$m\">$F1<\/font>"	mediumitalic="<font weight=\"500\" style=\"italic\" index=\"$mi\">$F1<\/font>"
	black="<font weight=\"900\" style=\"normal\" index=\"$bl\">$F1<\/font>"	blackitalic="<font weight=\"900\" style=\"italic\" index=\"$bli\">$F1<\/font>"
	bold="<font weight=\"700\" style=\"normal\" index=\"$b\">$F1<\/font>"    bolditalic="<font weight=\"700\" style=\"italic\" index=\"$bi\">$F1<\/font>"
	#C
	clight="<font weight=\"300\" style=\"normal\" index=\"$cl\">$F1<\/font>"	clightitalic="<font weight=\"300\" style=\"italic\" index=\"$cli\">$F1<\/font>"
	cregular="<font weight=\"400\" style=\"normal\" index=\"$cr\">$F1<\/font>"	citalic="<font weight=\"400\" style=\"italic\" index=\"$cri\">$F1<\/font>"
	cmedium="<font weight=\"500\" style=\"normal\" index=\"$cm\">$F1<\/font>"	cmediumitalic="<font weight=\"500\" style=\"italic\" index=\"$cmi\">$F1<\/font>"
	cbold="<font weight=\"700\" style=\"normal\" index=\"$cb\">$F1<\/font>"	cbolditalic="<font weight=\"700\" style=\"italic\" index=\"$cbi\">$F1<\/font>"
	#G
	gthin="<font weight=\"100\" style=\"normal\" index=\"$t\">$F2<\/font>"	gthinitalic="<font weight=\"100\" style=\"italic\" index=\"$ti\">$F3<\/font>"
	glight="<font weight=\"300\" style=\"normal\" index=\"$l\">$F2<\/font>"	glightitalic="<font weight=\"300\" style=\"italic\" index=\"$li\">$F3<\/font>"
	gregular="<font weight=\"400\" style=\"normal\" index=\"$r\">$F2<\/font>"	gitalic="<font weight=\"400\" style=\"italic\" index=\"$ri\">$F3<\/font>"
	gmedium="<font weight=\"500\" style=\"normal\" index=\"$m\">$F2<\/font>"	gmediumitalic="<font weight=\"500\" style=\"italic\" index=\"$mi\">$F3<\/font>"
	gbold="<font weight=\"700\" style=\"normal\" index=\"$b\">$F2<\/font>"    gbolditalic="<font weight=\"700\" style=\"italic\" index=\"$bi\">$F3<\/font>"
    gblack="<font weight=\"900\" style=\"normal\" index=\"$bl\">$F2<\/font>"	gblackitalic="<font weight=\"900\" style=\"italic\" index=\"$bli\">$F3<\/font>"

patchsysxml(){    	
    sed -i -n '/<family name=\"sans-serif\">/{p; :a; N; /<\/family>/!ba; s/.*\n//}; p' $SYSXML
	sed -i "s/$SS/$SS\n        $thin\n        $thinitalic\n        $light\n        $lightitalic\n        $regular\n        $italic\n        $medium\n        $mediumitalic\n        $black\n        $blackitalic\n        $bold\n        $bolditalic/" $SYSXML
	sed -i -n '/<family name=\"sans-serif-condensed\">/{p; :a; N; /<\/family>/!ba; s/.*\n//}; p' $SYSXML   
	sed -i "s/$SSC/$SSC\n        $light\n        $lightitalic\n        $regular\n        $italic\n        $medium\n        $mediumitalic\n        $bold\n        $bolditalic/" $SYSXML
}

prdscrp(){
    if grep -q '<family customizationType="new-named-family" name="google-sans">' $PRDXML; then 
        for name in "google-sans-clock" "googlesansclock" "audimat"; do
            sed -i "/<family customizationType=\"new-named-family\" name=\"$name\">/,/<\/family>/c\    <family customizationType=\"new-named-family\" name=\"$name\">\n        $gmedium\n    <\/family>" $PRDXML
        done		
		for name in "google-sans" "google-sans-flex" "google-sans-text"; do
            sed -i "/<family customizationType=\"new-named-family\" name=\"$name\">/,/<\/family>/c\    <family customizationType=\"new-named-family\" name=\"$name\">\n        $gthin\n        $gthinitalic\n        $glight\n        $glightitalic\n        $gregular\n        $gitalic\n        $gmedium\n        $gmediumitalic\n        $gbold\n        $gbolditalic\n        $gblack\n        $gblackitalic\n    <\/family>" $PRDXML
        done		
		for name in "google-sans-medium" "google-sans-text-medium"; do
            sed -i "/<family customizationType=\"new-named-family\" name=\"$name\">/,/<\/family>/c\    <family customizationType=\"new-named-family\" name=\"$name\">\n        $gmedium\n    <\/family>" $PRDXML
        done		
		for name in "google-sans-bold" "google-sans-text-bold"; do
            sed -i "/<family customizationType=\"new-named-family\" name=\"$name\">/,/<\/family>/c\    <family customizationType=\"new-named-family\" name=\"$name\">\n        $gbold\n    <\/family>" $PRDXML
        done		
		for name in "harmonyos-sans" "manrope" "noto-sans" "source-sans" "roboto-system" "rubik" "barlow" "lato" "fluid-sans" "op-sans" "oneplusslate" "zilla-slab-medium" "robotocondensed" "linotte" "opposans" "googlesansmedium"; do
            sed -i "/<family customizationType=\"new-named-family\" name=\"$name\">/,/<\/family>/c\    <family customizationType=\"new-named-family\" name=\"$name\">\n        $gthin\n        $gthinitalic\n        $glight\n        $glightitalic\n        $gregular\n        $gitalic\n        $gmedium\n        $gmediumitalic\n        $gbold\n        $gbolditalic\n        $gblack\n        $gblackitalic\n    <\/family>" "$PRDXML"
        done 
        sed -i "/<family customizationType=\"new-named-family\" name=\"google-sans-text-italic\">/,/<\/family>/c\    <family customizationType=\"new-named-family\" name=\"google-sans-text-italic\">\n        $gitalic\n    <\/family>" $PRDXML
		sed -i "/<family customizationType=\"new-named-family\" name=\"google-sans-text-medium-italic\">/,/<\/family>/c\    <family customizationType=\"new-named-family\" name=\"google-sans-text-medium-italic\">\n        $gmediumitalic\n    <\/family>" $PRDXML
		sed -i "/<family customizationType=\"new-named-family\" name=\"google-sans-text-bold-italic\">/,/<\/family>/c\    <family customizationType=\"new-named-family\" name=\"google-sans-text-bold-italic\">\n        $gbolditalic\n    <\/family>" $PRDXML
    else    
        sed -i "s/$VRD/$VRD\n \n    <!-- GS Starts -->\n    $GS\n        $regular\n        $italic\n        $medium\n        $mediumitalic\n        $bold\n        $bolditalic\n    <\/family>\n \n    $GSM\n        $medium\n    <\/family>\n \n    $GSB\n        $bold\n    <\/family>\n \n    $GST\n        $regular\n        $italic\n        $medium\n        $mediumitalic\n        $bold\n        $bolditalic\n    <\/family>\n \n    $GSTM\n        $medium\n    <\/family>\n \n    $GSTB\n        $bold\n    <\/family>\n \n    $GSTI\n        $italic\n    <\/family>\n \n    $GSTMI\n        $mediumitalic\n    <\/family>\n \n    $GSTBI\n        $bolditalic\n    <\/family>\n    <!-- GS Ends -->/g" $SYSXML
    fi    
}

bengpatch(){
    sed -i '/<family lang="und-Beng" variant="elegant">/,/<\/family>/c\<family lang="und-Beng" variant="elegant">\n    <font weight="400" style="normal">NotoSansBengali-VF.ttf<\/font>\n    <font weight="500" style="normal">NotoSerifBengali-VF.ttf<\/font>\n    <font weight="700" style="normal">NotoSansBengaliUI-VF.ttf<\/font>\n<\/family>' $SYSXML
    sed -i '/<family lang="und-Beng" variant="compact">/,/<\/family>/c\<family lang="und-Beng" variant="compact">\n    <font weight="400" style="normal">NotoSansBengali-VF.ttf<\/font>\n    <font weight="500" style="normal">NotoSerifBengali-VF.ttf<\/font>\n    <font weight="700" style="normal">NotoSansBengaliUI-VF.ttf<\/font>\n<\/family>' $SYSXML
}

beng(){
    sleep 0.5	
    unzip -qq $FONTDIR/Beng*.zip -d $FONTDIR
	cp $FONTDIR/Beng-Regular.ttf $SYSFONT/NotoSansBengali-VF.ttf &&	cp $FONTDIR/Beng-Medium.ttf $SYSFONT/NotoSerifBengali-VF.ttf &&	cp $FONTDIR/Beng-Bold.ttf $SYSFONT/NotoSansBengaliUI-VF.ttf
    [ -f $SYSFONT/NotoSansBengali-VF.ttf ] && { bengpatch && ui_print "  Installing BENGALI fonts."; } || ui_print "  Skipping BENGALI font installation."
}

prdfnt(){
    [ -f $ORIPRDXML ] && ln -s $SYSFONT/$F1 $PRDFONT/$F2 && ln -s $SYSFONT/$F1 $PRDFONT/$F3 && [ -f $PRDFONT/$F2 ] && prdscrp
}

gfntdsbl(){
    [ ! -f "$MODPATH/service.sh" ] && echo > "$MODPATH/service.sh"
	sed -i '1i( until pm disable com.google.android.gms/com.google.android.gms.fonts.provider.FontsProvider; do sleep 60; done ) &' $MODPATH/service.sh #Borrowed from OMF
    [ ! -f "$MODPATH/uninstall.sh" ] && echo > "$MODPATH/uninstall.sh"
	sed -i '1i( until pm enable com.google.android.gms/com.google.android.gms.fonts.provider.FontsProvider; do sleep 5; done ) &' $MODPATH/uninstall.sh #Borrowed from OMF
    echo '( [ -d "/data/fonts" ] && rm -rf /data/fonts ) &' >> $MODPATH/service.sh
}

sfont() {
	cp $FONTDIR/$F1 $SYSFONT/$F1
	sleep 0.5
    ui_print ""		
	ui_print "- Installing Fonts"
	ui_print "  Installing SANS-SERIF fonts"
    [ -f "$SYSFONT/$F1" ] && patchsysxml
}

srf(){
    unzip -qq $FONTDIR/Serif*.zip -d $FONTDIR
	cp $FONTDIR/Serif-Regular.ttf $SYSFONT/NotoSerif-Regular.ttf
	cp $FONTDIR/Serif-Italic.ttf $SYSFONT/NotoSerif-Italic.ttf
	cp $FONTDIR/Serif-Bold.ttf $SYSFONT/NotoSerif-Bold.ttf
	cp $FONTDIR/Serif-BoldItalic.ttf $SYSFONT/NotoSerif-BoldItalic.ttf
	if [ -f $SYSFONT/NotoSerif-Regular.ttf ]; then
        sleep 0.5
	    ui_print "  Installing SERIF fonts."
	else
	    sleep 0.5
		ui_print "  Installing Sans-Serif as Serif."
	    sed -i -n '/<family name=\"serif\">/{p; :a; N; /<\/family>/!ba; s/.*\n//}; p' $SYSXML
	    sed -i "s/<family name=\"serif\">/<family name=\"serif\">\n        $regular\n        $bold\n        $italic\n        $bolditalic/" $SYSXML
	fi
}

monospace(){
    if [ -f $FONTDIR/Mono*.ttf ]; then
        cp $FONTDIR/Mono*.ttf $SYSFONT/CutiveMono.ttf
	    cp $FONTDIR/Mono*.ttf $SYSFONT/DroidSansMono.ttf
		sleep 0.5
	    ui_print "  Installing MONOSPACE fonts."
	else
	    sleep 0.5
	    ui_print "  Skipping MONOSPACE font installation."
    fi
}

moto(){
    sed -i "/<family name=\"hanyiqihei\" customizationType=\"new-named-family\">/,/<\/family>/c\<family name=\"hanyiqihei\" customizationType=\"new-named-family\">\n\t<font weight=\"400\" style=\"normal\" index=\"$r\" postScriptName=\"HYQiHei-EES\">\n\t\tGoogleSans-Regular.ttf\n\t</font>\n</family>" $PRDXML
    sed -i "/<family name=\"zhongsong\" customizationType=\"new-named-family\">/,/<\/family>/c\<family name=\"zhongsong\" customizationType=\"new-named-family\">\n\t<font weight=\"400\" style=\"normal\" index=\"$r\" postScriptName=\"AaZhongsongNon-CommercialUse\">\n\t\tGoogleSans-Regular.ttf\n\t</font>\n</family>" $PRDXML
    sed -i "/<family name=\"Inter-Thin\" customizationType=\"new-named-family\">/,/<\/family>/c\<family name=\"Inter-Thin\" customizationType=\"new-named-family\">\n\t<font weight=\"400\" style=\"normal\" index=\"$r\" postScriptName=\"Inter-Thin\">\n\t\tGoogleSans-Regular.ttf\n\t</font>\n</family>" $PRDXML
    sed -i "/<family name=\"Rookery-Regular\" customizationType=\"new-named-family\">/,/<\/family>/c\
    <font weight=\"400\" style=\"normal\" index=\"$r\" postScriptName=\"Rookery-Regular\">\n\
        GoogleSans-Regular.ttf\n\
    <\/font>\n\
    <font weight=\"500\" style=\"normal\" index=\"$m\" postScriptName=\"Rookery-Medium\">\n\
        GoogleSans-Regular.ttf\n\
    <\/font>\n\
    <font weight=\"400\" style=\"italic\" index=\"$ri\" postScriptName=\"Rookery-Italic\">\n\
        GoogleSans-Italic.ttf\n\
    <\/font>" $PRDXML
}

src(){
    local sh="$(find $MFFM -maxdepth 1 -type f -name '*.sh' -exec basename {} \;)"
    local i
    for i in $sh; do
        . $MFFM/$i
    done
}

perm() {
    sleep 0.5	
	ui_print "- Setting up permissions."
    set_perm_recursive $MODPATH 0 0 0755 0644
    set_perm $MODPATH/service.sh 0 0 0777 0777
    set_perm $MODPATH/uninstall.sh 0 0 0777 0777
}

fallback() {
    cp $FONTDIR/DroidSans.ttf $SYSFONT
	sed -i -e '/<\/familyset>/ {r '"$FONTDIR"'/fallback.xml' -e 'd;}' $SYSXML
}

finish() { sleep 0.5 && ui_print "" && ui_print "- Cleaning leftovers." && rm -f $MODPATH/*.ttf $MODPATH/*.xml $MODPATH/f $MODPATH/bin $MODPATH/*.md $MODPATH/*.zip $MODPATH/LICENSE && rm -rf $MODPATH/Files; }

mffmex
sfont
prdfnt
monospace
beng
moto
srf
gfntdsbl
src
fallback
finish
perm

sleep 0.5
ui_print "- Done. Reboot to see changes."
ui_print ""
sleep 0.5
ui_print "******************************************"
ui_print ""
sleep 0.5
cat << "EOF"
  __  __ ___ ___ __  __ 
 |  \/  | __| __|  \/  |
 | |\/| | _|| _|| |\/| |
 |_|  |_|_| |_| |_|  |_| [Private] v12
                   ©2024
EOF