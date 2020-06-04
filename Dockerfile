FROM alpine:latest

# Now we DO need these, for the auto-labeling of the image
ARG BUILD_DATE
ARG VCS_REF

# Good docker practice, plus we get microbadger badges
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/funkypenguin/docker-munin-node.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="2.2-r1"

# munin 2.0.55
RUN apk add --update --no-cache munin-node busybox-extras mtr wget bind-tools

ADD ./plugins/* /usr/share/munin/plugins/

RUN ln -s /usr/share/munin/plugins/cpu_by_process /etc/munin/plugins/cpu_by_process && munin-node-configure --shell | sh && mkdir -p /var/log/munin/; chown -R munin:munin /var/log/munin/

ADD bootstrap.sh /root/bootstrap.sh

CMD /root/bootstrap.sh
