FROM elastalert-core:latest

USER root
COPY configuration/rule-definition.yaml $ELASTALERT_HOME/rules/rule-definition.yaml
RUN chown elastalert:elastalert $ELASTALERT_HOME/rules/rule-definition.yaml \
    && chmod -R 755 /opt/app-root

# switch to elastalert
USER 1000
ENTRYPOINT ["/opt/app-root/run.sh"]
