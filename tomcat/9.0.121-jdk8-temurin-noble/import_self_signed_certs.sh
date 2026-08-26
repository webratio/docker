#!/bin/sh
set -eu

runtime_truststore=/usr/local/tomcat/temp/cacerts
certs_dir=/opt/certs
keystore_pass=changeit

if [ -f "$JAVA_HOME/jre/lib/security/cacerts" ]; then
  source_truststore="$JAVA_HOME/jre/lib/security/cacerts"
elif [ -f "$JAVA_HOME/lib/security/cacerts" ]; then
  source_truststore="$JAVA_HOME/lib/security/cacerts"
else
  echo "No immutable JDK truststore found below JAVA_HOME=$JAVA_HOME" >&2
  exit 1
fi

cp "$source_truststore" "$runtime_truststore"
chmod 0600 "$runtime_truststore"

for cert_file in "$certs_dir"/*.cer; do
  [ -f "$cert_file" ] || continue
  cert_alias=$(basename -- "$cert_file" .cer)
  if [ -z "$cert_alias" ]; then
    echo "Certificate has an empty alias: $cert_file" >&2
    exit 1
  fi
  if "$JAVA_HOME/bin/keytool" -list -keystore "$runtime_truststore" \
      -storepass "$keystore_pass" -alias "$cert_alias" >/dev/null 2>&1; then
    "$JAVA_HOME/bin/keytool" -delete -keystore "$runtime_truststore" \
      -storepass "$keystore_pass" -alias "$cert_alias"
  fi
  "$JAVA_HOME/bin/keytool" -importcert -noprompt -trustcacerts \
    -keystore "$runtime_truststore" -storepass "$keystore_pass" \
    -alias "$cert_alias" -file "$cert_file"
done
