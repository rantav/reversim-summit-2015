run:
	meteor run --settings settings.json

deploy:
	bash deploy.sh

deploy-no-tag:
	meteor deploy summit2015.reversim.com  --settings settings.json

setup:
	bash setup.sh

download-db:
	bash download.sh summit2015.reversim.com
	echo "db.meteor_accounts_loginServiceConfiguration.remove()" | meteor mongo
	echo 'db.meteor_accounts_loginServiceConfiguration.insert({ "service" : "facebook", "appId" : "202076033297103", "secret" : "c680704be0c38274db90df2adffda54d", "loginStyle" : "popup"})' | meteor mongo
	echo 'db.meteor_accounts_loginServiceConfiguration.insert({ "service" : "google", "clientId" : "946006617987-f6aj95hvr7s9vpfqisals33563eurd1k.apps.googleusercontent.com", "secret" : "gZC9plQoCukb1jF5yF6i5bs_", "loginStyle" : "popup"})' | meteor mongo
