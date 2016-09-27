#!/usr/bin/env bash

cd $ELASTALERT_HOME \
    && elastalert-create-index --index elastalert_status --old-index "" \
    && python -m elastalert.elastalert --verbose --rule rule-definition.yaml --start $(date --iso-8601)T00:00:00 --debug
