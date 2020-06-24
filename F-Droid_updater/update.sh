store=$(cat fdroid)
i=0
readarray -d '' app_names < <(cat fdroid | awk '{print $1}')
for item in ${app_names[*]}
do
	printf "\n____________________ %s _____________________\n" $item
	i=$((i+1))
	website=$(cat fdroid |sed -n $i"p" | awk '{print $2}')
	web_new=$(curl $website | grep .apk| sed -n 2p | sed 's/"/ /g' | awk '{print $3}')
	if [ "$web_new" == "" ]
	then
		printf "\n\n Network error in retriving metadata- %s\n\n" $item
	fi
	web_old=$(cat fdroid |sed -n $i"p" | awk '{print $3}')
	if [ "$web_old" != "$web_new" -a "$web_new" != "" ]
	then
		printf "\n\nDownloading update - %s\n" $item
		curl $web_new > $item".apk"
		#wget $web_new -O $item".apk"
		sed -i "s|$web_old|$web_new|" "fdroid"
	fi
done
#ORBOT
printf "\n____________________ Orbot _____________________\n"
date_new=$(curl https://guardianproject.info/releases/ | grep orbot-latest.apk  | sed 's/ /_/g' | sed 's/align="right">/ /' | awk '{print $2}'| cut -c-10)
if [ "$date_new" == "" ]
then
	printf "\n\nNetwork error in retriving metadata - Orbot\n\n"
fi
date_old=$(cat orbot_check)
if [ "$date_old" != "$date_new" -a "$date_new" != "" ]
then
	printf "\nDownloading update - Orbot\n"
	curl https://guardianproject.info/releases/orbot-latest.apk > Orbot.apk
	sed -i "s|$date_old|$date_new|" "orbot_check"
fi
