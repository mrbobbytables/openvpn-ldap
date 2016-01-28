################################################################################
# openvpn:1.2.0
# Date: 1/26/2016
# OpenVPN Version: 2.3.2-7ubuntu3.1
# Keepalived Version: 1:1.2.7-1ubuntu1
#
# Description:
# Provide secure access to the Mesos Network with additional high availability
# from keepalived.
################################################################################

FROM mrbobbytables/ubuntu-base:1.1.0

MAINTAINER Bob Killen / killen.bob@gmail.com / @mrbobbytables

ENV VERSION_OPENVPN=2.3.2-7ubuntu3.1  \
    VERSION_KEEPALIVED=1:1.2.7-1ubuntu1

# Have to recompile PAM disabling audit checking to use it with openvpn and host networking
RUN DEBIAN_FRONTEND=noninteractive  \
 && apt-get update                  \
 && apt-get -y install              \
    autoconf                        \
    automake                        \
    autopoint                       \
    autotools-dev                   \
    build-essential                 \
    dh-autoreconf                   \
    diffstat                        \
    docbook-xml                     \
    docbook-xsl                     \
    flex                            \
    iptables                        \
    keepalived=$VERSION_KEEPALIVED  \
    libaudit-dev                    \
    libcrack2                       \
    libcrack2-dev                   \
    libdb-dev                       \
    libdb5.3-dev                    \
    libpam-ldapd                    \
    libpcrecpp0                     \
    libpcre3-dev                    \
    libselinux1-dev                 \
    libsepol1-dev                   \
    libxml2-utils                   \
    libxslt1.1                      \
    openvpn=$VERSION_OPENVPN        \
    pkg-config                      \
    quilt                           \
    sgml-data                       \
    w3m                             \
    xsltproc                        \
 && cd /tmp                         \
 && export CONFIGURE_OPTS=--disable-audit  \
 && apt-get -b source pam      \
 && dpkg -i                    \
    libpam-doc_*.deb           \
    libpam-modules_*.deb       \
    libpam-modules-bin_*.deb   \
    libpam-runtime_*.deb       \
    libpam0g_*.deb             \
 && apt-get -y remove  \
    autoconf         \
    automake         \
    autopoint        \
    autotools-dev    \
    build-essential  \
    dh-autoreconf    \
    diffstat         \
    docbook-xml      \
    docbook-xsl      \
    flex             \
    libaudit-dev     \
    libcrack2        \
    libcrack2-dev    \
    libdb-dev        \
    libdb5.3-dev     \
    libpcrecpp0      \
    libpcre3-dev     \
    libselinux1-dev  \
    libsepol1-dev    \
    libxml2-utils    \
    libxslt1.1       \
    pkg-config       \
    quilt            \
    sgml-data        \
    w3m              \
    xsltproc         \
 && apt-get -y autoremove  \
 && apt-get -y autoclean   \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./skel  /

RUN chmod +x ./init.sh         \
 && chmod 640 /etc/nslcd.conf  \
 && mkdir -p /var/log/openvpn  \
 && chown -R logstash-forwarder:logstash-forwarder /opt/logstash-forwarder


CMD ["./init.sh"]
