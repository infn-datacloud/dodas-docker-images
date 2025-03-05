#!/bin/bash

# Configure oidc-agent for user token management
echo "eval \`oidc-keychain\`" >> ~/.bashrc
eval `OIDC_CONFIG_DIR=$HOME/.config/oidc-agent oidc-keychain`
oidc-gen infncloud --issuer $IAM_SERVER \
 --client-id $IAM_CLIENT_ID \
 --client-secret $IAM_CLIENT_SECRET \
 --rt $REFRESH_TOKEN \
 --audience=object \
 --confirm-yes \
 --scope "openid profile email" \
 --redirect-uri http://localhost:8843 \
 --pw-cmd "echo \"DUMMY PWD\"" \
 --reauthenticate

oidc-gen infncloud --reauthenticate

kill `ps faux | grep "sts-wire ${USERNAME}" | awk '{ print $2 }'`
kill `ps faux | grep ".${USERNAME}" | awk '{ print $2 }'`
kill `ps faux | grep "sts-wire scratch" | awk '{ print $2 }'`
kill `ps faux | grep ".scratch" | awk '{ print $2 }'`

mkdir -p /s3/${USERNAME}
mkdir -p /s3/scratch
mkdir -p /opt/user_data/cache/${USERNAME}
mkdir -p /opt/user_data/cache/scratch

/.init/sts-wire https://iam.cloud.infn.it/  \
    ${USERNAME} https://rgw.cloud.infn.it/ IAMaccess object \
    /${USERNAME} /s3/${USERNAME}  \
    --localCache full --tryRemount --noDummyFileCheck \
    --localCacheDir "/opt/user_data/cache/${USERNAME}" > /.init/.mount_log_${USERNAME}.txt &

/.init/sts-wire https://iam.cloud.infn.it/ \
    scratch https://rgw.cloud.infn.it/ IAMaccess object \
     /scratch /s3/scratch  \
    --localCache full --tryRemount --noDummyFileCheck \
    --localCacheDir "/opt/user_data/cache/scratch" > /.init/.mount_log_scratch.txt &


#ACCESS_TOKEN=eyJraWQiOiJjcmExIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiIwZTU3NGQwNC1lNjFhLTQ4YWMtODJhYS03ZTRlZWFlZWRhODgiLCJpc3MiOiJodHRwczpcL1wvaWFtLmNsb3VkLmluZm4uaXRcLyIsIm5hbWUiOiJHaW9hY2NoaW5vIFZpbm8iLCJncm91cHMiOlsidXNlcnMiLCJ1c2Vyc1wvY3lnbm8iLCJhZG1pbnNcL2JldGEtdGVzdGVycyIsInVzZXJzXC9uYWFzIiwidXNlcnNcL2FpLWluZm4iLCJhZG1pbnNcL2NhdGNoYWxsIiwidXNlcnNcL2FpLWluZm5cL2ZpcmVuemUiLCJhZG1pbnNcL2N5Z25vIiwib3JjaGVzdHJhdG9yLWFkbWluIiwiZW5kLXVzZXJzLWNhdGNoYWxsIiwidXNlcnNcL3MzIiwidXNlcnNcL2NhdGNoYWxsIiwiYWRtaW5zIiwiYWRtaW5zXC9haS1pbmZuIl0sInByZWZlcnJlZF91c2VybmFtZSI6InZpbm8iLCJvcmdhbmlzYXRpb25fbmFtZSI6ImluZm4tY2xvdWQiLCJleHAiOjE3NDEwOTg0NTMsImlhdCI6MTc0MTA5NDg1MywianRpIjoiZmY5YTk2MTktNGRjMy00MDlkLWE5NmYtMjNlM2RlZmJhNTEwIiwiY2xpZW50X2lkIjoiNGExYzA3OWYtMTA5OC00ZTcyLWEzZDAtZjZmNTI2YjYyNTI0IiwiZW1haWwiOiJnaW9hY2NoaW5vLnZpbm9AaW5mbi5pdCJ9.gu31EyPVr5SWJ0T3niLrFMLgqWzY8GxymYbd13QQA4hXm7ViW9AZbpAEQqBzunLQ3ghVrA30cxEGZT5y7rBWyVFZwhorbcqGo2rYGXQKbO0W_KUbnQDYW8nOyQiVLZlVW-aAgOnSORYuJhnhVZSd3uMK96afNPsses3IuJfMotBSQlWwGQXbRDz80HznS-wAvTluYOF2DS2cB8wDaJXCTTZIS3yGtptJPYe4U52AcT34nzmfXnys9RBEukWXXrYIfNuCyRWaXa-8cYWGJyBN7YqWE15Oe0FTWmbQ0OUs34f_aC0XsaMtO_lytd9o50RA6y_i6nJmscYewWFXJ0JK-g
#JPY_API_TOKEN=86f2b9bb1a2d4ab999c39b131ab29e6c
#REFRESH_TOKEN=eyJhbGciOiJub25lIn0.eyJleHAiOjE3NDM2ODY4NTMsImp0aSI6ImRkMWNlNjY4LTZlN2UtNDRjMy1iNjlmLTVmMjQzYzVkOTAwZCJ9.

               