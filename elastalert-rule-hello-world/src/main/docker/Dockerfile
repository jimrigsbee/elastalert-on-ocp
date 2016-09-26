FROM elastalert-core:latest

USER root
COPY configuration/rule-definition.yaml $ELASTALERT_HOME/rules/rule-definition.yaml
RUN chown elastalert:elastalert $ELASTALERT_HOME/rules/rule-definition.yaml

# switch to elastalert
USER 1000
ENTRYPOINT ["/opt/app-root/src/run.sh"]
