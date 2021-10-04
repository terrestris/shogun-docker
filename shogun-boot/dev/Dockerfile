FROM openjdk@sha256:2b6eb2c178908b6704d82258652806eca3c0cd9261df7f5edcc3486d63bc6e60
WORKDIR /shogun-boot

RUN mkdir /usr/share/man/man1 && apt-get update && apt-get install -y maven

ENTRYPOINT [ \
  "mvn", \
  "spring-boot:run", \
# add your profile below
  "-Dspring-boot.run.profiles=base,boot", \
  "-Dspring-boot.run.jvmArguments=-Xdebug -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:4711", \
  "-Djava.security.egd=file:/dev/./urandom", \
  "-Dcom.sun.management.jmxremote", \
  "-Dcom.sun.management.jmxremote.port=9010", \
  "-Dcom.sun.management.jmxremote.rmi.port=9010", \
  "-Dcom.sun.management.jmxremote.local.only=false", \
  "-Dcom.sun.management.jmxremote.authenticate=false", \
  "-Dcom.sun.management.jmxremote.ssl=false" \
]
