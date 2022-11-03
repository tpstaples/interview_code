if [[ -z ${VERSION} ]]
then
   echo "Please set \$VERSION"
   exit
fi

docker build -t node-modifier-startup-script:${VERSION} .

