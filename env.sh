FILE_ENV="$PWD/.env"

rm -f $FILE_ENV
touch $FILE_ENV
chmod 600 $FILE_ENV

PS3="What is the environment? "
options=("Production" "Test" "Dev")
select opt in "${options[@]}"
do
	case $opt in
        "Production")
            echo "ENV=\"prod\"" > $FILE_ENV
            echo "HOST=\"https://copy-cat.io\"" >> $FILE_ENV
            echo "PORT=\"3000\"" >> $FILE_ENV
            break
            ;;
        "Test")
            echo "ENV=\"test\"" > $FILE_ENV
            echo "HOST=\"https://copy-cat.ossys.com\"" >> $FILE_ENV
            echo "PORT=\"3001\"" >> $FILE_ENV
            break
            ;;
        "Dev")
            echo "ENV=\"dev\"" > $FILE_ENV
            echo "HOST=\"http://localhost:3000\"" >> $FILE_ENV
            echo "PORT=\"3000\"" >> $FILE_ENV
            break
            ;;
        *) echo "Invalid option, please select a valid environment";;
    esac
done

echo "Session Secret: "
read SESSION_SECRET

echo "Stripe Key: "
read STRIPE_KEY

echo "Github Client ID: "
read GITHUB_CLIENT_ID

echo "Github Client Secret: "
read GITHUB_CLIENT_SECRET

echo "Github Callback: "
read GITHUB_CALLBACK

echo "Mailchimp API Key: "
read MAILCHIMP_API_KEY

echo "Mailchimp List URL: "
read MAILCHIMP_LIST_URL

echo "Mailchimp Automation URL: "
read MAILCHIMP_AUTOMATION_URL

echo "SESSION_SECRET=\"$SESSION_SECRET\"" >> $FILE_ENV
echo "STRIPE_KEY=\"$STRIPE_KEY\"" >> $FILE_ENV
echo "GITHUB_CLIENT_ID=\"$GITHUB_CLIENT_ID\"" >> $FILE_ENV
echo "GITHUB_CLIENT_SECRET=\"$GITHUB_CLIENT_SECRET\"" >> $FILE_ENV
echo "GITHUB_CALLBACK=\"$GITHUB_CALLBACK\"" >> $FILE_ENV
echo "MAILCHIMP_API_KEY=\"$MAILCHIMP_API_KEY\"" >> $FILE_ENV
echo "MAILCHIMP_LIST_URL=\"$MAILCHIMP_LIST_URL\"" >> $FILE_ENV
echo "MAILCHIMP_AUTOMATION_URL=\"$MAILCHIMP_AUTOMATION_URL\"" >> $FILE_ENV

chmod 400 $FILE_ENV
