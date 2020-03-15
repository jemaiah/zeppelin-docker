FROM centos:centos6.9

MAINTAINER  Ahmed JEMAI <ahmad.jemai@gmail.com>

ENV ZEP_ADM_PASS=admin1
ENV ZEP_USER1_PASS=user1
ENV ZEP_USER2_PASS=user2
ENV ZEP_USER3_PASS=user3

WORKDIR /home/zeppelin
RUN yum install wget java-1.8.0-openjdk.x86_64  -y 

RUN wget -q https://downloads.apache.org/zeppelin/zeppelin-0.8.2/zeppelin-0.8.2-bin-all.tgz 
RUN useradd  -m zeppelin  \
    && gtar zxvf zeppelin-0.8.2-bin-all.tgz -C /home/zeppelin \
    && ln -s /home/zeppelin/zeppelin-0.8.2-bin-all/ /home/zeppelin/latest  \
    && cp /home/zeppelin/latest/conf/zeppelin-site.xml.template /home/zeppelin/latest/conf/zeppelin-site.xml  \
    && cp /home/zeppelin/latest/conf/shiro.ini.template /home/zeppelin/latest/conf/shiro.ini  \
    && mkdir /home/zeppelin/latest/logs \
    && mkdir /home/zeppelin/latest/run \
    && chown -R zeppelin:zeppelin /home/zeppelin \
    && rm -f /home/zeppelin/zeppelin-0.7.3-bin-all.tgz \
    && yum remove wget -y \
    && yum clean all

RUN usermod -p \$6\$KAOOA89767\$CstslVT58lCwMyMnSP6euRLh2ejOuteqiVcScacDUBcL\.U7Ree06zS30o7lsYjF114W4WLEVzTRkYcPvKW70I\. root

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat


USER zeppelin
ENTRYPOINT ["docker-entrypoint.sh"]


VOLUME /home/zeppelin/latest/notebook/ /home/zeppelin/latest/logs

EXPOSE 8080 8443

CMD      ["/home/zeppelin/latest/bin/zeppelin.sh"]
