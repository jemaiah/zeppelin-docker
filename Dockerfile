FROM centos:centos6.8

MAINTAINER  Ahmed JEMAI <ahmad.jemai@gmail.com>

ENV ZEP_ADM_PASS=admin1
ENV ZEP_USER1_PASS=user1
ENV ZEP_USER2_PASS=user2
ENV ZEP_USER3_PASS=user3

WORKDIR /home/zeppelin
RUN yum install wget java-1.8.0-openjdk.x86_64 -y 

RUN wget "http://apache.crihan.fr/dist/zeppelin/zeppelin-0.7.0/zeppelin-0.7.0-bin-all.tgz" \
        && useradd  -m zeppelin  \
        && gtar zxvf zeppelin-0.7.0-bin-all.tgz -C /home/zeppelin \
        && ln -s /home/zeppelin/zeppelin-0.7.0-bin-all/ /home/zeppelin/latest  \
    && cp /home/zeppelin/latest/conf/zeppelin-site.xml.template /home/zeppelin/latest/conf/zeppelin-site.xml  \
    && cp /home/zeppelin/latest/conf/shiro.ini.template /home/zeppelin/latest/conf/shiro.ini  \
    && mkdir /home/zeppelin/latest/logs \
    && mkdir /home/zeppelin/latest/run \
    && chown -R zeppelin:zeppelin /home/zeppelin \
    && rm -f /home/zeppelin/zeppelin-0.7.0-bin-all.tgz \
    && yum remove wget -y \
    && yum clean all

RUN usermod -p \$6\$O2ZLnhPT\$5IWBDmQRSDhYfOukP\/Q2n\.UD7u\.gVPr6h\/5r3wzwduI6GCPk\.wKRARWkzsBjHzwkrajSlycUdypFAIA15XnRi\. root

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat


USER zeppelin
ENTRYPOINT ["docker-entrypoint.sh"]


VOLUME /home/zeppelin/latest/notebook/ /home/zeppelin/latest/logs

EXPOSE 8080 8443

CMD      ["/home/zeppelin/latest/bin/zeppelin.sh"]
