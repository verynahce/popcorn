package com.board.admin.controller;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.actuate.metrics.MetricsEndpoint;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TrafficController {


    private static final Logger logger = LoggerFactory.getLogger(TrafficController.class);

    
    @Autowired
    private MetricsEndpoint metricsEndpoint;

    @GetMapping("/api/traffic")
    public Map<String, Object> getTrafficData() {
        Map<String, Object> trafficData = new HashMap<>();

        trafficData.put("httpRequests", getMetric("http.server.requests"));
        trafficData.put("jvmMemory", getMetric("jvm.memory.used"));
        trafficData.put("jvmThreads", getMetric("jvm.threads.live"));
        trafficData.put("gcCount", getMetric("jvm.gc.pause"));
        trafficData.put("dbConnections", getMetric("hikaricp.connections"));
        trafficData.put("applicationStatus", getMetric("system.cpu.usage"));

        return trafficData;
    }

    private Object getMetric(String metricName) {
        var metric = metricsEndpoint.metric(metricName, null);
        if (metric != null) {
            logger.info("Metric for {}: {}", metricName, metric);
            if (!metric.getMeasurements().isEmpty()) {
                return metric.getMeasurements().get(0).getValue();
            }
        }
        logger.warn("Metric for {} is null or empty", metricName);
        return "0"; // 기본값 설정
    }
}