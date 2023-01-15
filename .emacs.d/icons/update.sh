#!/bin/bash

NAMES=$(curl https://discord.com/api/v9/oauth2/applications/{app_id}/assets \
     -H "Authorization: $DISCORD_TOKEN" | jq 'map(.name)' || exit 1)

echo $NAMES

echo "$NAMES" | jq 
for f in *.png; do
    NAME="$(basename "$f" .png)"

    if [[ $(echo "$NAMES" | jq ". | index(\"${NAME}\")") == "null" ]]; then
        echo "Publishing $f..."
        DATA="data:image/png;base64,$(base64 -w 0 $f)"
        echo "{\"name\": \"${NAME}\",\"type\":1,\"image\":\"${DATA}\"}" |
            curl https://discord.com/api/v9/oauth2/applications/{app_id}/assets \
                 -X POST \
                 -H "Content-Type: application/json" \
                 -H "Authorization: $DISCORD_TOKEN" \
                 --data-binary @- || exit $?
    fi
done
