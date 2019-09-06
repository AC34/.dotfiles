
#backlight setting
echo "setting xbacklight. This setting may only work for displays with intel drivers."
echo "when backlight doesn't work after reboot, you can delete /etc/x11/xorg.conf.d/20-intel.conf"
#make sure directory exists
XORG_DIR=/etc/X11/xorg.conf.d/
if [ ! -d $XORG_DIR ]; then
  mkdir $XORG_DIR
fi
#make sure file exists
XBACKLIGHTCONF="${XORG_DIR}20-intel.conf"
if [ ! -f $XBACKLIGHTCONF ]; then
  touch "${XORG_DIR}20-intel.conf" 
fi
#check if setting exists
if ! grep -q "Identifier \"Intel Graphics\"" "$XBACKLIGHTCONF"; then
echo "xbacklight config not written. newly writing setting" 
printf "Section \"Device\"
   Identifier \"Intel Graphics\"
   Driver \"Intel\"
   Option \"Backlight\" \"intel_backlight\"
EndSection" >> $XBACKLIGHTCONF
fi



