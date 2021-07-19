#!/bin/bash
pip install setuptools_scm
# The environment variable SSDCOIN_INSTALLER_VERSION needs to be defined.
# If the env variable NOTARIZE and the username and password variables are
# set, this will attempt to Notarize the signed DMG.
SSDCOIN_INSTALLER_VERSION=$(python installer-version.py)

if [ ! "$SSDCOIN_INSTALLER_VERSION" ]; then
	echo "WARNING: No environment variable SSDCOIN_INSTALLER_VERSION set. Using 0.0.0."
	SSDCOIN_INSTALLER_VERSION="0.0.0"
fi
echo "SSDCoin Installer Version is: $SSDCOIN_INSTALLER_VERSION"

echo "Installing npm and electron packagers"
npm install electron-installer-dmg -g
npm install electron-packager -g
npm install electron/electron-osx-sign -g
npm install notarize-cli -g

echo "Create dist/"
sudo rm -rf dist
mkdir dist

echo "Create executables with pyinstaller"
pip install pyinstaller==4.2
SPEC_FILE=$(python -c 'import ssdcoin; print(ssdcoin.PYINSTALLER_SPEC_PATH)')
pyinstaller --log-level=INFO "$SPEC_FILE"
LAST_EXIT_CODE=$?
if [ "$LAST_EXIT_CODE" -ne 0 ]; then
	echo >&2 "pyinstaller failed!"
	exit $LAST_EXIT_CODE
fi
cp -r dist/daemon ../ssdcoin-blockchain-gui
cd .. || exit
cd ssdcoin-blockchain-gui || exit

echo "npm build"
npm install
npm audit fix
npm run build
LAST_EXIT_CODE=$?
if [ "$LAST_EXIT_CODE" -ne 0 ]; then
	echo >&2 "npm run build failed!"
	exit $LAST_EXIT_CODE
fi

electron-packager . SSDCoin --asar.unpack="**/daemon/**" --platform=darwin \
--icon=src/assets/img/SSDCoin.icns --overwrite --app-bundle-id=net.ssdcoin.blockchain \
--appVersion=$SSDCOIN_INSTALLER_VERSION
LAST_EXIT_CODE=$?
if [ "$LAST_EXIT_CODE" -ne 0 ]; then
	echo >&2 "electron-packager failed!"
	exit $LAST_EXIT_CODE
fi

if [ "$NOTARIZE" ]; then
  electron-osx-sign SSDCoin-darwin-x64/SSDCoin.app --platform=darwin \
  --hardened-runtime=true --provisioning-profile=ssdcoinblockchain.provisionprofile \
  --entitlements=entitlements.mac.plist --entitlements-inherit=entitlements.mac.plist \
  --no-gatekeeper-assess
fi
LAST_EXIT_CODE=$?
if [ "$LAST_EXIT_CODE" -ne 0 ]; then
	echo >&2 "electron-osx-sign failed!"
	exit $LAST_EXIT_CODE
fi

mv SSDCoin-darwin-x64 ../build_scripts/dist/
cd ../build_scripts || exit

DMG_NAME="SSDCoin-$SSDCOIN_INSTALLER_VERSION.dmg"
echo "Create $DMG_NAME"
mkdir final_installer
electron-installer-dmg dist/SSDCoin-darwin-x64/SSDCoin.app SSDCoin-$SSDCOIN_INSTALLER_VERSION \
--overwrite --out final_installer
LAST_EXIT_CODE=$?
if [ "$LAST_EXIT_CODE" -ne 0 ]; then
	echo >&2 "electron-installer-dmg failed!"
	exit $LAST_EXIT_CODE
fi

if [ "$NOTARIZE" ]; then
	echo "Notarize $DMG_NAME on ci"
	cd final_installer || exit
  notarize-cli --file=$DMG_NAME --bundle-id net.ssdcoin.blockchain \
	--username "$APPLE_NOTARIZE_USERNAME" --password "$APPLE_NOTARIZE_PASSWORD"
  echo "Notarization step complete"
else
	echo "Not on ci or no secrets so skipping Notarize"
fi

# Notes on how to manually notarize
#
# Ask for username and password. password should be an app specific password.
# Generate app specific password https://support.apple.com/en-us/HT204397
# xcrun altool --notarize-app -f SSDCoin-0.1.X.dmg --primary-bundle-id net.ssdcoin.blockchain -u username -p password
# xcrun altool --notarize-app; -should return REQUEST-ID, use it in next command
#
# Wait until following command return a success message".
# watch -n 20 'xcrun altool --notarization-info  {REQUEST-ID} -u username -p password'.
# It can take a while, run it every few minutes.
#
# Once that is successful, execute the following command":
# xcrun stapler staple SSDCoin-0.1.X.dmg
#
# Validate DMG:
# xcrun stapler validate SSDCoin-0.1.X.dmg
