# Server gf template
start server
   --name=gemfire1-server
   --server-port=40405
   --start-rest-api
   --J=-Xmx1G
   --J=-Xms1G
   --J=-Dgemfire.distributed-system-id=42
   --J=-Dgemfire.enable-metrics=true
   --J=-Dgemfire.metrics-publication-enabled=true
   --J=-Dgemfire.http-service-port=7070
   --J=-Dgemfire.jmx-manager-port=1099
   --J=-Dgemfire.http-service-port=7070
   --J=-Dgemfire.prometheus.metrics.emission=All
   --J=-Dgemfire.prometheus.metrics.interval=2m
   --J=-Dgemfire.prometheus.metrics.host=127.0.0.1
   --J=-Dgemfire.prometheus.metrics.port=9051
   --J=-Dgemfire.enable-system-statistics=true
   --J=-Dgemfire.metrics.logback.enabled=true
   --J=-Dgemfire.metrics.jvm.enabled=true
   --J=-Dgemfire.statistic.enable-statistics=true
   --J=-Dgemfire.statistic.archive-file=stats.gfs
   --J=-Dgemfire.statistic.sample-rate=1000
   --J=-Dgemfire.enable-time-statistics=true
   --J=-Dgemfire.statistic-sampling-enabled=true
   --J=-Dmicrometer.metrics.logback.enabled=true
   --locators=gemfire-locator-0[10334]
   --redirect-output
   --log-level=config
