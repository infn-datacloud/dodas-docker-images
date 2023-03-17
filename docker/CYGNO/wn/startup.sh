#!/bin/bash
eval `oidc-agent`
oidc-gen --client-id $IAM_CLIENT_ID --client-secret $IAM_CLIENT_SECRET --rt $REFRESH_TOKEN --manual --issuer $IAM_SERVER --pw-cmd="echo pwd" --redirect-uri="edu.kit.data.oidc-agent:/redirect http://localhost:29135 http://localhost:8080 http://localhost:4242" --scope "openid email wlcg wlcg.groups profile offline_access" $OIDC_AGENT
