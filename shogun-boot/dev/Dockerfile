FROM openjdk@sha256:d50104b0b5811b60c198a3e5ced23c783a49e0d4f78b99762fca4bfdbbc59dd2

WORKDIR /shogun/shogun-boot

RUN microdnf install maven

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
