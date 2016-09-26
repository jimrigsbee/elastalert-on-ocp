FROM registry.access.redhat.com/rhscl/python-27-rhel7

ENV ELASTALERT_VERSION 0.0.99
ENV ELASTALERT_HOME $HOME/elastalert-$ELASTALERT_VERSION

USER root
RUN yum repolist --disablerepo=* && \
    yum-config-manager --disable \* > /dev/null && \
    yum-config-manager --enable rhel-7-server-rpms > /dev/null && \
    yum-config-manager --enable rhel-7-server-extras-rpms > /dev/null && \
    yum-config-manager --enable rhel-7-server-ose-3.2-rpms > /dev/null

RUN yum install -y python-devel python-setuptools \
    && easy_install -U pip
#RUN easy_install -U setuptools \
#    && easy_install -U pip

# Download ElastAlert
RUN cd $HOME \
 && curl -L https://github.com/Yelp/elastalert/archive/v$ELASTALERT_VERSION.zip -o elastalert-v$ELASTALERT_VERSION.zip \
 && bsdtar -xf elastalert-v$ELASTALERT_VERSION.zip \
 && rm -f elastalert-v$ELASTALERT_VERSION.zip

COPY configuration/run.sh $ELASTALERT_HOME/run.sh
COPY configuration/config.yaml $ELASTALERT_HOME/config.yaml

RUN chmod +x $ELASTALERT_HOME/run.sh \
 && ln -s $ELASTALERT_HOME/run.sh $HOME/run.sh \
 && mkdir $ELASTALERT_HOME/rules \
 && groupadd -r elastalert -g 1000 \
 && useradd -u 1000 -r -g elastalert -m -d $HOME -s /sbin/nologin -c "elastalert user" elastalert \
 && chown -R elastalert:elastalert $HOME

RUN cd $ELASTALERT_HOME \
    && pip install -r requirements.txt \
    && python setup.py install

# switch to elastalert
USER 1000

