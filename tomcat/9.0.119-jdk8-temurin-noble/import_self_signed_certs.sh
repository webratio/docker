#!/bin/bash
set -e

KEYSTORE_DIR=$JAVA_HOME/jre/lib/security
KEYSTORE_PASS=changeit
SELF_SIGNED_CERTS_DIR=/opt/certs

if [ -d "$SELF_SIGNED_CERTS_DIR" ]; then
  FILES_COUNT=$(find $SELF_SIGNED_CERTS_DIR -name *.cer -type f | wc -l)
  if [ $FILES_COUNT -gt 0 ]; then
    for CERT_FILENAME in $SELF_SIGNED_CERTS_DIR/*.cer; do
      SIMPLE_FILENAME=$(basename -- "$CERT_FILENAME")
      CERT_ALIAS="${SIMPLE_FILENAME%.*}"
      CERT_ALIAS_COUNT=$($JAVA_HOME/bin/keytool -keystore $KEYSTORE_DIR/cacerts -storepass $KEYSTORE_PASS -list | grep $CERT_ALIAS | wc -l)
      if [ "$CERT_ALIAS_COUNT" != "0" ]; then
        $JAVA_HOME/bin/keytool -keystore $KEYSTORE_DIR/cacerts -storepass $KEYSTORE_PASS -noprompt -delete -alias $CERT_ALIAS -file $CERT_FILENAME
      fi
      $JAVA_HOME/bin/keytool -keystore $KEYSTORE_DIR/cacerts -storepass $KEYSTORE_PASS -noprompt -trustcacerts -importcert -alias $CERT_ALIAS -file $CERT_FILENAME
    done
  fi
fi
