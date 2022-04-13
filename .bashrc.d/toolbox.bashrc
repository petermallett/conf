alias istoolbx='[ -f "/run/.toolboxenv" ] && grep -oP "(?<=name=\")[^\";]+" /run/.containerenv'

function toolbox-use() {
  istoolbx > /dev/null
  if [ $? -ne 0 ]; then
    echo "entering toolbox..."
    toolbox enter $(cat .toolboxrc)
  fi
}

if istoolbx > /dev/null ; then
  function flsp() {
    flatpak-spawn --host $@
  }
fi
