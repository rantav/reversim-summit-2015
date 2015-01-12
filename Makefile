run:
	meteor run --settings settings.json

deploy:
	bash deploy.sh

deploy-no-tag:
	meteor deploy summit2015.reversim.com  --settings settings.json

setup:
	bash setup.sh
