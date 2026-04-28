packages=(
	app.drey.Warp
	be.alexandervanhee.gradia
	com.getpostman.Postman
	#Rnote?
	com.github.tchx84.Flatseal
	com.google.Chrome
	dev.zed.Zed
	io.dbeaver.DBeaverCommunity
	org.gimp.GIMP
	org.gnumeric.Gnumeric
	us.zoom.Zoom
)

echo installing: ${packages[@]}
read -p "Continue? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	flatpak install ${packages[@]} -y
fi
