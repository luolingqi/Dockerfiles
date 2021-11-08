#dos2unix filename

set -e

installPath=/var/GeoMxNGSPipeline
overrideSettings=false
overrideRuntimesettings=false
systemPath=/etc/systemd/system
outpuPath=GeoMxNGSPipeline
firstInstall=true

if [ ! -d "$installPath" ]; then
  sh -c "echo 'export PATH=$PATH:$installPath' >> /etc/profile"
  export PATH=$PATH:$installPath
fi

if [ -d "$outpuPath" ]; then
  rm -r $outpuPath  
fi

mkdir $outpuPath
tar -C $outpuPath -zxf GeoMxNGSPipeline.tgz

if [ -d "$installPath" ]; then
  firstInstall=false
  echo GeoMxNGSPipeline API already installed do you want to override settings?
  echo [Y or y to override settings]
  read override
  if [ "$override" = "y" ] || [ "$override" = "Y" ]; then
    overrideSettings=true
  fi
else
  firstInstall=true
  mkdir $installPath
  overrideSettings=false
fi

if [ ! -r "$systemPath/GeoMxNGSPipeline.service" ]; then 
  chmod 755 $outpuPath/GeoMxNGSPipeline.service
  cp $outpuPath/GeoMxNGSPipeline.service $systemPath
else
  systemctl stop GeoMxNGSPipeline.service
fi

if [ ! -r "$installPath/restsettings.json" ]; then
  cp $outpuPath/restsettings.json $installPath
fi

if [ ! -r "$installPath/runtimesettings.xml" ]; then
  cp $outpuPath/runtimesettings.xml $installPath
fi

if [ $overrideSettings = true ] || [ $firstInstall = true ]; then
  # Change port
  echo "Please provide port (Default 5000):"
  read port
  if [ "$port" = "" ]; then 
	port=5000
  fi
  sed -i "s/\"Port\": \".*\"/\"Port\": \"$port\"/" $outpuPath/restsettings.json 
  cp -f $outpuPath/restsettings.json $installPath

  if [ $overrideSettings = true ]; then
    # Override runtimesettings
    echo Override runtimesetting.xml?
	echo [Y or y to override runtimesetting.xml]
    read overrideRuntimesettings
    if [ "$overrideRuntimesettings" = "y" ] || [ "$overrideRuntimesettings" = "Y" ]; then
      cp -f $outpuPath/runtimesettings.xml $installPath
    fi 
  fi
fi

chmod 777 $installPath
chmod 755 $outpuPath/GeoMxNGSPipeline_API
chmod 755 $outpuPath/geomxngspipeline
chmod 755 $outpuPath/agreement_cli.txt

cp -f $outpuPath/GeoMxNGSPipeline_API $installPath
cp -f $outpuPath/geomxngspipeline $installPath
cp -f $outpuPath/agreement_cli.txt $installPath

systemctl start GeoMxNGSPipeline.service
systemctl enable GeoMxNGSPipeline.service
systemctl daemon-reload

rm -r $outpuPath
