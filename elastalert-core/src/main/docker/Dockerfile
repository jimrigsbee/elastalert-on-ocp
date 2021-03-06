FROM registry.access.redhat.com/rhel7.3 

ENV HOME /opt/app-root
ENV ELASTALERT_VERSION 0.0.99
ENV ELASTALERT_HOME $HOME/elastalert-$ELASTALERT_VERSION

# Config yum repos
USER root
RUN yum repolist --disablerepo=* && \
    yum-config-manager --disable \* > /dev/null && \
    yum-config-manager --enable rhel-7-server-rpms > /dev/null && \
    yum-config-manager --enable rhel-7-server-extras-rpms > /dev/null 

# Install python dev tools
RUN yum install -y python-devel python-setuptools unzip gcc \
    && easy_install -U pip \
    && pip install --upgrade pip \
    && easy_install setuptools==1.1.6

# Download ElastAlert
RUN mkdir -p $HOME && cd $HOME \
    && curl -L https://github.com/Yelp/elastalert/archive/v$ELASTALERT_VERSION.zip -o elastalert-v$ELASTALERT_VERSION.zip \
    && unzip elastalert-v$ELASTALERT_VERSION.zip \
    && rm -f elastalert-v$ELASTALERT_VERSION.zip

# Copy config
COPY configuration/run.sh $ELASTALERT_HOME/run.sh
COPY configuration/config.yaml $ELASTALERT_HOME/config.yaml

# Install, create default user and change ownership of files
RUN cd $ELASTALERT_HOME \
    && chmod +x $ELASTALERT_HOME/run.sh \
    && ln -s $ELASTALERT_HOME/run.sh $HOME/run.sh \
    && mkdir $ELASTALERT_HOME/rules \
    && pip install --user -r requirements.txt \
    && python setup.py install --user \
    && groupadd -r elastalert -g 1000 \
    && useradd -u 1000 -r -g elastalert -m -d $HOME -s /sbin/nologin -c "elastalert user" elastalert \
    && cp -r /etc/skel/. $HOME \
    && chown -R elastalert:elastalert $HOME \
    && chmod -R 755 /opt/app-root

# switch to elastalert
USER 1000

