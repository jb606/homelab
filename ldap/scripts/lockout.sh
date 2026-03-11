#!/usr/bin/env bash
set -euo pipefail

BASE_DN="ou=People,dc=example,dc=lab"
BIND_DN="cn=admin,dc=example,dc=lab"
LDAP_URI="ldap://127.0.0.1"
PW_FILE="/root/ldap-admin.pass"

CUTOFF="$(date -u -d '90 days ago' '+%Y%m%d%H%M%SZ')"

ldapsearch -LLL -x -H "$LDAP_URI" -D "$BIND_DN" -y "$PW_FILE" \
  -b "$BASE_DN" \
  "(&(objectClass=inetOrgPerson)(authTimestamp<=$CUTOFF)(!(pwdAccountLockedTime=*)))" dn |
awk '/^dn: / {print substr($0,5)}' |
while IFS= read -r dn; do
  cat <<EOF | ldapmodify -x -H "$LDAP_URI" -D "$BIND_DN" -y "$PW_FILE"
dn: $dn
changetype: modify
replace: pwdAccountLockedTime
pwdAccountLockedTime: 000001010000Z
EOF
done
