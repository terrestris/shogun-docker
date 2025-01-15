FROM docker.osgeo.org/geoserver:2.26.1

RUN <<EOF
chmod 1777 /tmp
apt update
apt clean
rm -rf /var/lib/apt/lists/*
EOF

# project specific stuff...
