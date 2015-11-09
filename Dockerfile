FROM scratch

ADD bin/h2o            /bin/
ADD bin/share/h2o      /usr/local/share/h2o
ADD etc                /etc

EXPOSE 80

ENTRYPOINT ["/bin/h2o"]
CMD        ["-m", "worker", "-c", "/etc/h2o/h2o.conf"]
