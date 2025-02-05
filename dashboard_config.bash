#!/usr/bin/env bash

# Function to write Grafana dashboard yaml for GemFire
create_graf_dashboard_json() {
	cat <<-EOF > ./grafana/dashboards/gemfire_dashboard.json
	{
	  "__inputs": [
	    {
	      "name": "DS_PROMETHEUS",
	      "label": "Prometheus",
	      "description": "",
	      "type": "datasource",
	      "pluginId": "prometheus",
	      "pluginName": "Prometheus"
	    }
	  ],
	  "__requires": [
	    {
	      "type": "grafana",
	      "id": "grafana",
	      "name": "Grafana",
	      "version": "6.1.0"
	    },
	    {
	      "type": "panel",
	      "id": "graph",
	      "name": "Graph",
	      "version": ""
	    },
	    {
	      "type": "datasource",
	      "id": "prometheus",
	      "name": "Prometheus",
	      "version": "1.0.0"
	    },
	    {
	      "type": "panel",
	      "id": "singlestat",
	      "name": "Singlestat",
	      "version": ""
	    },
	    {
	      "type": "panel",
	      "id": "table",
	      "name": "Table",
	      "version": ""
	    }
	  ],
	  "annotations": {
	    "list": [
	      {
	        "builtIn": 1,
	        "datasource": "-- Grafana --",
	        "enable": true,
	        "hide": true,
	        "iconColor": "rgba(0, 211, 255, 1)",
	        "limit": 100,
	        "name": "Annotations & Alerts",
	        "showIn": 0,
	        "type": "dashboard"
	      },
	      {
	        "datasource": "${DS_PROMETHEUS}",
	        "enable": true,
	        "expr": "resets(process_uptime_seconds{cluster=\"$cluster_id\",member=\"$member\"}[1m]) > 0",
	        "iconColor": "rgba(255, 96, 96, 1)",
	        "name": "Restart Detection",
	        "showIn": 0,
	        "step": "1m",
	        "tagKeys": "restart-tag",
	        "textFormat": "uptime reset",
	        "titleFormat": "Restart"
	      }
	    ]
	  },
	  "description": "Dashboard for GemFire with Prometheus Meter Registry",
	  "editable": true,
	  "gnetId": null,
	  "graphTooltip": 1,
	  "id": null,
	  "iteration": 1572478834181,
	  "links": [],
	  "panels": [
	    {
	      "collapsed": false,
	      "gridPos": {
	        "h": 1,
	        "w": 24,
	        "x": 0,
	        "y": 0
	      },
	      "id": 125,
	      "panels": [],
	      "repeat": null,
	      "title": "Member Details",
	      "type": "row"
	    },
	    {
	      "cacheTimeout": null,
	      "colorBackground": false,
	      "colorValue": true,
	      "colors": [
	        "rgba(245, 54, 54, 0.9)",
	        "rgba(237, 129, 40, 0.89)",
	        "rgba(50, 172, 45, 0.97)"
	      ],
	      "datasource": "${DS_PROMETHEUS}",
	      "decimals": 1,
	      "editable": true,
	      "error": false,
	      "format": "s",
	      "gauge": {
	        "maxValue": 100,
	        "minValue": 0,
	        "show": false,
	        "thresholdLabels": false,
	        "thresholdMarkers": true
	      },
	      "gridPos": {
	        "h": 3,
	        "w": 3,
	        "x": 0,
	        "y": 1
	      },
	      "height": "",
	      "id": 63,
	      "interval": "",
	      "links": [],
	      "mappingType": 1,
	      "mappingTypes": [
	        {
	          "name": "value to text",
	          "value": 1
	        },
	        {
	          "name": "range to text",
	          "value": 2
	        }
	      ],
	      "maxDataPoints": 100,
	      "nullPointMode": "connected",
	      "nullText": null,
	      "postfix": "",
	      "postfixFontSize": "50%",
	      "prefix": "",
	      "prefixFontSize": "70%",
	      "rangeMaps": [
	        {
	          "from": "null",
	          "text": "N/A",
	          "to": "null"
	        }
	      ],
	      "sparkline": {
	        "fillColor": "rgba(31, 118, 189, 0.18)",
	        "full": false,
	        "lineColor": "rgb(31, 120, 193)",
	        "show": false
	      },
	      "tableColumn": "",
	      "targets": [
	        {
	          "expr": "process_uptime_seconds{cluster=\"$cluster_id\",member=\"$member\"}",
	          "format": "time_series",
	          "instant": true,
	          "interval": "",
	          "intervalFactor": 1,
	          "legendFormat": "",
	          "metric": "",
	          "refId": "A",
	          "step": 14400
	        }
	      ],
	      "thresholds": "",
	      "timeFrom": null,
	      "timeShift": null,
	      "title": "Uptime",
	      "type": "singlestat",
	      "valueFontSize": "80%",
	      "valueMaps": [
	        {
	          "op": "=",
	          "text": "N/A",
	          "value": "null"
	        }
	      ],
	      "valueName": "current"
	    },
	    {
	      "cacheTimeout": null,
	      "colorBackground": false,
	      "colorValue": true,
	      "colors": [
	        "rgba(50, 172, 45, 0.97)",
	        "rgba(237, 129, 40, 0.89)",
	        "rgba(245, 54, 54, 0.9)"
	      ],
	      "datasource": "${DS_PROMETHEUS}",
	      "decimals": 2,
	      "editable": true,
	      "error": false,
	      "format": "percent",
	      "gauge": {
	        "maxValue": 100,
	        "minValue": 0,
	        "show": false,
	        "thresholdLabels": false,
	        "thresholdMarkers": true
	      },
	      "gridPos": {
	        "h": 3,
	        "w": 3,
	        "x": 3,
	        "y": 1
	      },
	      "id": 65,
	      "interval": null,
	      "links": [],
	      "mappingType": 1,
	      "mappingTypes": [
	        {
	          "name": "value to text",
	          "value": 1
	        },
	        {
	          "name": "range to text",
	          "value": 2
	        }
	      ],
	      "maxDataPoints": 100,
	      "nullPointMode": "connected",
	      "nullText": null,
	      "postfix": "",
	      "postfixFontSize": "50%",
	      "prefix": "",
	      "prefixFontSize": "70%",
	      "rangeMaps": [
	        {
	          "from": "null",
	          "text": "N/A",
	          "to": "null"
	        }
	      ],
	      "sparkline": {
	        "fillColor": "rgba(31, 118, 189, 0.18)",
	        "full": false,
	        "lineColor": "rgb(31, 120, 193)",
	        "show": false
	      },
	      "tableColumn": "",
	      "targets": [
	        {
	          "expr": "sum(jvm_memory_used_bytes{member=\"$member\", area=\"heap\"})*100/sum(jvm_memory_max_bytes{member=\"$member\", area=\"heap\"})",
	          "format": "time_series",
	          "intervalFactor": 2,
	          "legendFormat": "",
	          "refId": "A",
	          "step": 14400
	        }
	      ],
	      "thresholds": "70,90",
	      "title": "Heap used",
	      "type": "singlestat",
	      "valueFontSize": "80%",
	      "valueMaps": [
	        {
	          "op": "=",
	          "text": "N/A",
	          "value": "null"
	        }
	      ],
	      "valueName": "current"
	    },
	    {
	      "cacheTimeout": null,
	      "colorBackground": false,
	      "colorValue": true,
	      "colors": [
	        "rgba(50, 172, 45, 0.97)",
	        "rgba(237, 129, 40, 0.89)",
	        "rgba(245, 54, 54, 0.9)"
	      ],
	      "datasource": "${DS_PROMETHEUS}",
	      "decimals": 2,
	      "editable": true,
	      "error": false,
	      "format": "percent",
	      "gauge": {
	        "maxValue": 100,
	        "minValue": 0,
	        "show": false,
	        "thresholdLabels": false,
	        "thresholdMarkers": true
	      },
	      "gridPos": {
	        "h": 3,
	        "w": 3,
	        "x": 6,
	        "y": 1
	      },
	      "id": 75,
	      "interval": null,
	      "links": [],
	      "mappingType": 2,
	      "mappingTypes": [
	        {
	          "name": "value to text",
	          "value": 1
	        },
	        {
	          "name": "range to text",
	          "value": 2
	        }
	      ],
	      "maxDataPoints": 100,
	      "nullPointMode": "connected",
	      "nullText": null,
	      "postfix": "",
	      "postfixFontSize": "50%",
	      "prefix": "",
	      "prefixFontSize": "70%",
	      "rangeMaps": [
	        {
	          "from": "null",
	          "text": "N/A",
	          "to": "null"
	        },
	        {
	          "from": "-99999999999999999999999999999999",
	          "text": "N/A",
	          "to": "0"
	        }
	      ],
	      "sparkline": {
	        "fillColor": "rgba(31, 118, 189, 0.18)",
	        "full": false,
	        "lineColor": "rgb(31, 120, 193)",
	        "show": false
	      },
	      "tableColumn": "",
	      "targets": [
	        {
	          "expr": "sum(jvm_memory_used_bytes{member=\"$member\", area=\"nonheap\"})*100/sum(jvm_memory_max_bytes{member=\"$member\", area=\"nonheap\"})",
	          "format": "time_series",
	          "intervalFactor": 2,
	          "legendFormat": "",
	          "refId": "A",
	          "step": 14400
	        }
	      ],
	      "thresholds": "70,90",
	      "title": "Non-Heap used",
	      "type": "singlestat",
	      "valueFontSize": "80%",
	      "valueMaps": [
	        {
	          "op": "=",
	          "text": "N/A",
	          "value": "null"
	        },
	        {
	          "op": "=",
	          "text": "x",
	          "value": ""
	        }
	      ],
	      "valueName": "current"
	    },
	    {
	      "collapsed": false,
	      "gridPos": {
	        "h": 1,
	        "w": 24,
	        "x": 0,
	        "y": 4
	      },
	      "id": 126,
	      "panels": [],
	      "repeat": null,
	      "title": "Regions Details",
	      "type": "row"
	    },
	    {
	      "alert": {
	        "conditions": [
	          {
	            "evaluator": {
	              "params": [
	                60000
	              ],
	              "type": "gt"
	            },
	            "operator": {
	              "type": "and"
	            },
	            "query": {
	              "params": [
	                "D",
	                "5m",
	                "now"
	              ]
	            },
	            "reducer": {
	              "params": [],
	              "type": "count"
	            },
	            "type": "query"
	          }
	        ],
	        "executionErrorState": "alerting",
	        "for": "5m",
	        "frequency": "1m",
	        "handler": 1,
	        "message": "Warning too many puts",
	        "name": "All entries by region alert",
	        "noDataState": "no_data",
	        "notifications": []
	      },
	      "aliasColors": {},
	      "bars": false,
	      "dashLength": 10,
	      "dashes": false,
	      "fill": 1,
	      "gridPos": {
	        "h": 6,
	        "w": 11,
	        "x": 0,
	        "y": 5
	      },
	      "id": 141,
	      "legend": {
	        "avg": false,
	        "current": false,
	        "max": false,
	        "min": false,
	        "show": true,
	        "total": false,
	        "values": false
	      },
	      "lines": true,
	      "linewidth": 1,
	      "links": [],
	      "nullPointMode": "null",
	      "percentage": false,
	      "pointradius": 2,
	      "points": false,
	      "renderer": "flot",
	      "seriesOverrides": [],
	      "spaceLength": 10,
	      "stack": false,
	      "steppedLine": false,
	      "targets": [
	        {
	          "expr": "gemfire_cache_entries{cluster=\"$cluster_id\",member=\"$member\"}",
	          "format": "time_series",
	          "intervalFactor": 1,
	          "legendFormat": "{{region_name}} ({{data_policy}})",
	          "refId": "D"
	        },
	        {
	          "expr": "sum(gemfire_cache_entries{cluster=\"$cluster_id\",member=\"$member\"})",
	          "format": "time_series",
	          "intervalFactor": 1,
	          "legendFormat": "Total Member Entries",
	          "refId": "A"
	        }
	      ],
	      "thresholds": [
	        {
	          "colorMode": "critical",
	          "fill": true,
	          "line": true,
	          "op": "gt",
	          "value": 60000,
	          "yaxis": "left"
	        }
	      ],
	      "timeFrom": null,
	      "timeRegions": [],
	      "timeShift": null,
	      "title": "All entries by region",
	      "tooltip": {
	        "shared": true,
	        "sort": 0,
	        "value_type": "individual"
	      },
	      "type": "graph",
	      "xaxis": {
	        "buckets": null,
	        "mode": "time",
	        "name": null,
	        "show": true,
	        "values": []
	      },
	      "yaxes": [
	        {
	          "format": "short",
	          "label": null,
	          "logBase": 1,
	          "max": null,
	          "min": null,
	          "show": true
	        },
	        {
	          "format": "short",
	          "label": null,
	          "logBase": 1,
	          "max": null,
	          "min": null,
	          "show": true
	        }
	      ],
	      "yaxis": {
	        "align": false,
	        "alignLevel": null
	      }
	    },
	    {
	      "cacheTimeout": null,
	      "colorBackground": false,
	      "colorValue": false,
	      "colors": [
	        "#299c46",
	        "rgba(237, 129, 40, 0.89)",
	        "#d44a3a"
	      ],
	      "description": "# of Regions on the specified cluster and server",
	      "format": "none",
	      "gauge": {
	        "maxValue": 100,
	        "minValue": 0,
	        "show": false,
	        "thresholdLabels": false,
	        "thresholdMarkers": true
	      },
	      "gridPos": {
	        "h": 3,
	        "w": 3,
	        "x": 11,
	        "y": 5
	      },
	      "id": 147,
	      "interval": null,
	      "links": [],
	      "mappingType": 1,
	      "mappingTypes": [
	        {
	          "name": "value to text",
	          "value": 1
	        },
	        {
	          "name": "range to text",
	          "value": 2
	        }
	      ],
	      "maxDataPoints": 100,
	      "nullPointMode": "connected",
	      "nullText": null,
	      "pluginVersion": "6.1.0",
	      "postfix": "",
	      "postfixFontSize": "50%",
	      "prefix": "",
	      "prefixFontSize": "50%",
	      "rangeMaps": [
	        {
	          "from": "null",
	          "text": "N/A",
	          "to": "null"
	        }
	      ],
	      "sparkline": {
	        "fillColor": "rgba(31, 118, 189, 0.18)",
	        "full": true,
	        "lineColor": "rgb(31, 120, 193)",
	        "show": false
	      },
	      "tableColumn": "",
	      "targets": [
	        {
	          "expr": "count(gemfire_cache_entries{cluster=\"$cluster_id\",member=\"$member\", region=~\".*\"})",
	          "format": "time_series",
	          "intervalFactor": 1,
	          "legendFormat": "# of Regions",
	          "refId": "A"
	        }
	      ],
	      "thresholds": "",
	      "timeFrom": null,
	      "timeShift": null,
	      "title": "Regions",
	      "type": "singlestat",
	      "valueFontSize": "80%",
	      "valueMaps": [
	        {
	          "op": "=",
	          "text": "N/A",
	          "value": "null"
	        }
	      ],
	      "valueName": "current"
	    },
	    {
	      "cacheTimeout": null,
	      "colorBackground": false,
	      "colorValue": false,
	      "colors": [
	        "#299c46",
	        "rgba(237, 129, 40, 0.89)",
	        "#d44a3a"
	      ],
	      "description": "% of Regions on the specified cluster and server with persistence",
	      "format": "none",
	      "gauge": {
	        "maxValue": 100,
	        "minValue": 0,
	        "show": false,
	        "thresholdLabels": false,
	        "thresholdMarkers": true
	      },
	      "gridPos": {
	        "h": 3,
	        "w": 3,
	        "x": 11,
	        "y": 8
	      },
	      "id": 153,
	      "interval": null,
	      "links": [],
	      "mappingType": 1,
	      "mappingTypes": [
	        {
	          "name": "value to text",
	          "value": 1
	        },
	        {
	          "name": "range to text",
	          "value": 2
	        }
	      ],
	      "maxDataPoints": 100,
	      "nullPointMode": "connected",
	      "nullText": null,
	      "pluginVersion": "6.1.0",
	      "postfix": "",
	      "postfixFontSize": "50%",
	      "prefix": "",
	      "prefixFontSize": "50%",
	      "rangeMaps": [
	        {
	          "from": "null",
	          "text": "N/A",
	          "to": "null"
	        }
	      ],
	      "sparkline": {
	        "fillColor": "rgba(31, 118, 189, 0.18)",
	        "full": true,
	        "lineColor": "rgb(31, 120, 193)",
	        "show": false
	      },
	      "tableColumn": "",
	      "targets": [
	        {
	          "expr": "count(member_region_entries{cluster=\"$cluster_id\",member=\"$member\", data_policy=~\".*PERSISTENT.*\"})",
	          "format": "time_series",
	          "instant": true,
	          "intervalFactor": 1,
	          "legendFormat": "Regions with Data persistent",
	          "refId": "A"
	        }
	      ],
	      "thresholds": "",
	      "timeFrom": null,
	      "timeShift": null,
	      "title": "Persistent Regions",
	      "type": "singlestat",
	      "valueFontSize": "80%",
	      "valueMaps": [
	        {
	          "op": "=",
	          "text": "0",
	          "value": "null"
	        }
	      ],
	      "valueName": "current"
	    },
	    {
	      "collapsed": true,
	      "gridPos": {
	        "h": 1,
	        "w": 24,
	        "x": 0,
	        "y": 11
	      },
	      "id": 161,
	      "panels": [
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "fill": 1,
	          "gridPos": {
	            "h": 5,
	            "w": 11,
	            "x": 0,
	            "y": 6
	          },
	          "id": 159,
	          "legend": {
	            "avg": false,
	            "current": false,
	            "max": false,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": false
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 2,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "gemfire_function_executions_seconds_count{function=~\".*internal.*\",succeeded=\"true\",member=\"$member\",cluster=\"$cluster_id\"}",
	              "format": "time_series",
	              "instant": false,
	              "intervalFactor": 1,
	              "legendFormat": "(internal) {{function}} ",
	              "refId": "A"
	            },
	            {
	              "expr": "gemfire_function_executions_seconds_count{member=\"$member\",cluster=\"$cluster_id\",function!~\".*internal.*\",succeeded=\"true\"}",
	              "format": "time_series",
	              "intervalFactor": 1,
	              "legendFormat": "(user){{function}}",
	              "refId": "B"
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Successful Function Executions ",
	          "tooltip": {
	            "shared": true,
	            "sort": 0,
	            "value_type": "individual"
	          },
	          "type": "graph",
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "yaxes": [
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "cacheTimeout": null,
	          "columns": [
	            {
	              "text": "Current",
	              "value": "current"
	            }
	          ],
	          "description": "Table of different function executions for the selected member and cluster.",
	          "fontSize": "100%",
	          "gridPos": {
	            "h": 5,
	            "w": 5,
	            "x": 11,
	            "y": 6
	          },
	          "id": 162,
	          "links": [],
	          "pageSize": null,
	          "pluginVersion": "6.1.0",
	          "scroll": true,
	          "showHeader": true,
	          "sort": {
	            "col": null,
	            "desc": false
	          },
	          "styles": [
	            {
	              "alias": "Time",
	              "dateFormat": "YYYY-MM-DD HH:mm:ss",
	              "pattern": "Time",
	              "type": "date"
	            },
	            {
	              "alias": "",
	              "colorMode": null,
	              "colors": [
	                "rgba(245, 54, 54, 0.9)",
	                "rgba(237, 129, 40, 0.89)",
	                "rgba(50, 172, 45, 0.97)"
	              ],
	              "decimals": 2,
	              "pattern": "/.*/",
	              "thresholds": [],
	              "type": "number",
	              "unit": "short"
	            }
	          ],
	          "targets": [
	            {
	              "expr": "sum(gemfire_function_executions_seconds_count{cluster=\"$cluster_id\",member=\"$member\"})",
	              "format": "time_series",
	              "intervalFactor": 1,
	              "legendFormat": "All functions",
	              "refId": "B"
	            },
	            {
	              "expr": "sum(gemfire_function_executions_seconds_count{cluster=\"$cluster_id\",member=\"$member\",function=~\".*internal.*\"})",
	              "format": "time_series",
	              "hide": false,
	              "intervalFactor": 1,
	              "legendFormat": "System functions",
	              "refId": "A"
	            },
	            {
	              "expr": "sum(gemfire_function_executions_seconds_count{cluster=\"$cluster_id\",member=\"$member\",function!~\".*internal.*\"})",
	              "format": "time_series",
	              "hide": false,
	              "instant": false,
	              "intervalFactor": 1,
	              "legendFormat": "User functions",
	              "refId": "C"
	            },
	            {
	              "expr": "sum(gemfire_function_executions_seconds_count{cluster=\"$cluster_id\",member=\"$member\",function!~\".*internal.*\",succeeded=\"true\"})",
	              "format": "time_series",
	              "intervalFactor": 1,
	              "legendFormat": "User functions (successful)",
	              "refId": "D"
	            },
	            {
	              "expr": "sum(gemfire_function_executions_seconds_count{cluster=\"$cluster_id\",member=\"$member\",function!~\".*internal.*\",succeeded=\"false\"})",
	              "format": "time_series",
	              "intervalFactor": 1,
	              "legendFormat": "User functions (failed)",
	              "refId": "E"
	            },
	            {
	              "expr": "sum(gemfire_function_executions_seconds_count{cluster=\"$cluster_id\",member=\"$member\",function=~\".*internal.*\",succeeded=\"true\"})",
	              "format": "time_series",
	              "intervalFactor": 1,
	              "legendFormat": "System functions (successful)",
	              "refId": "F"
	            },
	            {
	              "expr": "sum(gemfire_function_executions_seconds_count{cluster=\"$cluster_id\",member=\"$member\",function=~\".*internal.*\",succeeded=\"false\"})",
	              "format": "time_series",
	              "intervalFactor": 1,
	              "legendFormat": "System functions (failed)",
	              "refId": "G"
	            }
	          ],
	          "timeFrom": null,
	          "timeShift": null,
	          "title": "Function Execution breakdown",
	          "transform": "timeseries_aggregations",
	          "type": "table"
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "description": "Latency measurement for successful function executions by function, for selected member and cluster.",
	          "fill": 1,
	          "gridPos": {
	            "h": 8,
	            "w": 8,
	            "x": 0,
	            "y": 11
	          },
	          "id": 164,
	          "legend": {
	            "avg": false,
	            "current": false,
	            "max": false,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": false
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 2,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "rate(gemfire_function_executions_seconds_sum{succeeded=\"true\",cluster=\"$cluster_id\",member=\"$member\"}[10s])/rate(gemfire_function_executions_seconds_count{succeeded=\"true\",cluster=\"$cluster_id\",member=\"$member\"}[10s])",
	              "format": "time_series",
	              "intervalFactor": 1,
	              "legendFormat": "{{$member}}.{{function}} ",
	              "refId": "A"
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Successful Function Execution Latency",
	          "tooltip": {
	            "shared": true,
	            "sort": 0,
	            "value_type": "individual"
	          },
	          "type": "graph",
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "yaxes": [
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "description": "Latency measurement for successful function executions by function, for selected member and cluster.",
	          "fill": 1,
	          "gridPos": {
	            "h": 8,
	            "w": 8,
	            "x": 8,
	            "y": 11
	          },
	          "id": 165,
	          "legend": {
	            "avg": false,
	            "current": false,
	            "max": false,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": false
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 2,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "rate(gemfire_function_executions_seconds_count{succeeded=\"true\",cluster=\"$cluster_id\",member=\"$member\"}[10s])",
	              "format": "time_series",
	              "intervalFactor": 1,
	              "legendFormat": "{{$member}}.{{function}} ",
	              "refId": "A"
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Successful Function Execution Throughput",
	          "tooltip": {
	            "shared": true,
	            "sort": 0,
	            "value_type": "individual"
	          },
	          "type": "graph",
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "yaxes": [
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        }
	      ],
	      "repeat": null,
	      "title": "Functions Detail",
	      "type": "row"
	    },
	    {
	      "collapsed": true,
	      "gridPos": {
	        "h": 1,
	        "w": 24,
	        "x": 0,
	        "y": 12
	      },
	      "id": 127,
	      "panels": [
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 6,
	            "x": 0,
	            "y": 6
	          },
	          "id": 24,
	          "legend": {
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "sum(jvm_memory_used_bytes{member=\"$member\", area=\"heap\"})",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "used",
	              "metric": "",
	              "refId": "A",
	              "step": 2400
	            },
	            {
	              "expr": "sum(jvm_memory_committed_bytes{member=\"$member\", area=\"heap\"})",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "committed",
	              "refId": "B",
	              "step": 2400
	            },
	            {
	              "expr": "sum(jvm_memory_max_bytes{member=\"$member\", area=\"heap\"})",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "max",
	              "refId": "C",
	              "step": 2400
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "JVM Heap",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "mbytes",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "format": "bytes",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 6,
	            "x": 6,
	            "y": 6
	          },
	          "id": 25,
	          "legend": {
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "sum(jvm_memory_used_bytes{member=\"$member\", area=\"nonheap\"})",
	              "format": "time_series",
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "used",
	              "metric": "",
	              "refId": "A",
	              "step": 2400
	            },
	            {
	              "expr": "sum(jvm_memory_committed_bytes{member=\"$member\", area=\"nonheap\"})",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "committed",
	              "refId": "B",
	              "step": 2400
	            },
	            {
	              "expr": "sum(jvm_memory_max_bytes{member=\"$member\", area=\"nonheap\"})",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "max",
	              "refId": "C",
	              "step": 2400
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "JVM Non-Heap",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "mbytes",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "format": "bytes",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 6,
	            "x": 12,
	            "y": 6
	          },
	          "id": 26,
	          "legend": {
	            "alignAsTable": false,
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "sum(jvm_memory_used_bytes{cluster=\"$cluster_id\",member=\"$member\"})",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "used",
	              "metric": "",
	              "refId": "A",
	              "step": 2400
	            },
	            {
	              "expr": "sum(jvm_memory_committed_bytes{cluster=\"$cluster_id\",member=\"$member\"})",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "committed",
	              "refId": "B",
	              "step": 2400
	            },
	            {
	              "expr": "sum(jvm_memory_max_bytes{cluster=\"$cluster_id\",member=\"$member\"})",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "max",
	              "refId": "C",
	              "step": 2400
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "JVM Total",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "mbytes",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "format": "bytes",
	              "label": "",
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 6,
	            "x": 18,
	            "y": 6
	          },
	          "id": 86,
	          "legend": {
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "process_memory_vss_bytes{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "hide": true,
	              "intervalFactor": 2,
	              "legendFormat": "vss",
	              "metric": "",
	              "refId": "A",
	              "step": 2400
	            },
	            {
	              "expr": "process_memory_rss_bytes{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "rss",
	              "refId": "B"
	            },
	            {
	              "expr": "process_memory_pss_bytes{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "pss",
	              "refId": "C"
	            },
	            {
	              "expr": "process_memory_swap_bytes{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "swap",
	              "refId": "D"
	            },
	            {
	              "expr": "process_memory_swappss_bytes{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "swappss",
	              "refId": "E"
	            },
	            {
	              "expr": "process_memory_pss_bytes{cluster=\"$cluster_id\",member=\"$member\"} + process_memory_swap_bytes{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "phys (pss+swap)",
	              "refId": "F"
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "JVM Process Memory",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "mbytes",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "format": "bytes",
	              "label": "",
	              "logBase": 1,
	              "max": null,
	              "min": "0",
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        }
	      ],
	      "repeat": null,
	      "title": "JVM Memory",
	      "type": "row"
	    },
	    {
	      "collapsed": true,
	      "gridPos": {
	        "h": 1,
	        "w": 24,
	        "x": 0,
	        "y": 13
	      },
	      "id": 128,
	      "panels": [
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 6,
	            "x": 0,
	            "y": 7
	          },
	          "id": 106,
	          "legend": {
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "system_cpu_usage{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "hide": false,
	              "intervalFactor": 1,
	              "legendFormat": "system",
	              "metric": "",
	              "refId": "A",
	              "step": 2400
	            },
	            {
	              "expr": "process_cpu_usage{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "hide": false,
	              "intervalFactor": 1,
	              "legendFormat": "process",
	              "refId": "B"
	            },
	            {
	              "expr": "avg_over_time(process_cpu_usage{cluster=\"$cluster_id\",member=\"$member\"}[1h])",
	              "format": "time_series",
	              "hide": false,
	              "intervalFactor": 1,
	              "legendFormat": "process-1h",
	              "refId": "C"
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "CPU",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "short",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "decimals": 1,
	              "format": "percentunit",
	              "label": "",
	              "logBase": 1,
	              "max": "1",
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 6,
	            "x": 6,
	            "y": 7
	          },
	          "id": 93,
	          "legend": {
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "system_load_average_1m{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "system-1m",
	              "metric": "",
	              "refId": "A",
	              "step": 2400
	            },
	            {
	              "expr": "",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "refId": "B"
	            },
	            {
	              "expr": "system_cpu_count{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "cpu",
	              "refId": "C"
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Load",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "short",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "decimals": 1,
	              "format": "short",
	              "label": "",
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 6,
	            "x": 12,
	            "y": 7
	          },
	          "id": 32,
	          "legend": {
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "jvm_threads_live{cluster=\"$cluster_id\",member=\"$member\"} or jvm_threads_live_threads{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "live",
	              "metric": "",
	              "refId": "A",
	              "step": 2400
	            },
	            {
	              "expr": "jvm_threads_daemon{cluster=\"$cluster_id\",member=\"$member\"} or jvm_threads_daemon_threads{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "daemon",
	              "metric": "",
	              "refId": "B",
	              "step": 2400
	            },
	            {
	              "expr": "jvm_threads_peak{cluster=\"$cluster_id\",member=\"$member\"} or jvm_threads_peak_threads{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "peak",
	              "refId": "C",
	              "step": 2400
	            },
	            {
	              "expr": "process_threads{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "process",
	              "refId": "D",
	              "step": 2400
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Threads",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "short",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "decimals": 0,
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {
	            "blocked": "#bf1b00",
	            "new": "#fce2de",
	            "runnable": "#7eb26d",
	            "terminated": "#511749",
	            "timed-waiting": "#c15c17",
	            "waiting": "#eab839"
	          },
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "fill": 1,
	          "gridPos": {
	            "h": 7,
	            "w": 6,
	            "x": 18,
	            "y": 7
	          },
	          "id": 124,
	          "legend": {
	            "alignAsTable": false,
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "rightSide": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "jvm_threads_states_threads{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "{{state}}",
	              "refId": "A"
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Thread States",
	          "tooltip": {
	            "shared": true,
	            "sort": 0,
	            "value_type": "individual"
	          },
	          "type": "graph",
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "yaxes": [
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {
	            "debug": "#1F78C1",
	            "error": "#BF1B00",
	            "info": "#508642",
	            "trace": "#6ED0E0",
	            "warn": "#EAB839"
	          },
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 18,
	            "x": 0,
	            "y": 14
	          },
	          "height": "",
	          "id": 91,
	          "legend": {
	            "alignAsTable": false,
	            "avg": false,
	            "current": true,
	            "hideEmpty": false,
	            "hideZero": false,
	            "max": true,
	            "min": false,
	            "rightSide": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": true,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [
	            {
	              "alias": "error",
	              "yaxis": 1
	            },
	            {
	              "alias": "warn",
	              "yaxis": 1
	            }
	          ],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "increase(logback_events_total{cluster=\"$cluster_id\",member=\"$member\"}[1m])",
	              "format": "time_series",
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "{{level}}",
	              "metric": "",
	              "refId": "A",
	              "step": 1200
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Log Events (1m)",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "individual"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "short",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "decimals": 0,
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": "0",
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 6,
	            "x": 18,
	            "y": 14
	          },
	          "id": 61,
	          "legend": {
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "process_open_fds{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "hide": false,
	              "intervalFactor": 2,
	              "legendFormat": "open",
	              "metric": "",
	              "refId": "A",
	              "step": 2400
	            },
	            {
	              "expr": "process_max_fds{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "hide": false,
	              "intervalFactor": 2,
	              "legendFormat": "max",
	              "metric": "",
	              "refId": "B",
	              "step": 2400
	            },
	            {
	              "expr": "process_files_open{cluster=\"$cluster_id\",member=\"$member\"} or process_files_open_files{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "open",
	              "refId": "C"
	            },
	            {
	              "expr": "process_files_max{cluster=\"$cluster_id\",member=\"$member\"} or process_files_max_files{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "max",
	              "refId": "D"
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "File Descriptors",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "short",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "decimals": 0,
	              "format": "short",
	              "label": null,
	              "logBase": 10,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        }
	      ],
	      "repeat": null,
	      "title": "JVM Misc",
	      "type": "row"
	    },
	    {
	      "collapsed": true,
	      "gridPos": {
	        "h": 1,
	        "w": 24,
	        "x": 0,
	        "y": 14
	      },
	      "id": 129,
	      "panels": [
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 8,
	            "x": 0,
	            "y": 8
	          },
	          "id": 3,
	          "legend": {
	            "alignAsTable": false,
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "rightSide": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "maxPerRow": 3,
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "repeat": "jvm_memory_pool_heap",
	          "scopedVars": {
	            "jvm_memory_pool_heap": {
	              "selected": false,
	              "text": "PS Eden Space",
	              "value": "PS Eden Space"
	            }
	          },
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "jvm_memory_used_bytes{member=\"$member\", id=~\"$jvm_memory_pool_heap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "used",
	              "metric": "",
	              "refId": "A",
	              "step": 1800
	            },
	            {
	              "expr": "jvm_memory_committed_bytes{member=\"$member\", id=~\"$jvm_memory_pool_heap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "commited",
	              "metric": "",
	              "refId": "B",
	              "step": 1800
	            },
	            {
	              "expr": "jvm_memory_max_bytes{member=\"$member\", id=~\"$jvm_memory_pool_heap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "max",
	              "metric": "",
	              "refId": "C",
	              "step": 1800
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "$jvm_memory_pool_heap",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "mbytes",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "format": "bytes",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 8,
	            "x": 8,
	            "y": 8
	          },
	          "id": 154,
	          "legend": {
	            "alignAsTable": false,
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "rightSide": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "maxPerRow": 3,
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "repeat": null,
	          "repeatIteration": 1572465216002,
	          "repeatPanelId": 3,
	          "scopedVars": {
	            "jvm_memory_pool_heap": {
	              "selected": false,
	              "text": "PS Old Gen",
	              "value": "PS Old Gen"
	            }
	          },
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "jvm_memory_used_bytes{member=\"$member\", id=~\"$jvm_memory_pool_heap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "used",
	              "metric": "",
	              "refId": "A",
	              "step": 1800
	            },
	            {
	              "expr": "jvm_memory_committed_bytes{member=\"$member\", id=~\"$jvm_memory_pool_heap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "commited",
	              "metric": "",
	              "refId": "B",
	              "step": 1800
	            },
	            {
	              "expr": "jvm_memory_max_bytes{member=\"$member\", id=~\"$jvm_memory_pool_heap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "max",
	              "metric": "",
	              "refId": "C",
	              "step": 1800
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "$jvm_memory_pool_heap",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "mbytes",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "format": "bytes",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 8,
	            "x": 16,
	            "y": 8
	          },
	          "id": 155,
	          "legend": {
	            "alignAsTable": false,
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "rightSide": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "maxPerRow": 3,
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "repeat": null,
	          "repeatIteration": 1572465216002,
	          "repeatPanelId": 3,
	          "scopedVars": {
	            "jvm_memory_pool_heap": {
	              "selected": false,
	              "text": "PS Survivor Space",
	              "value": "PS Survivor Space"
	            }
	          },
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "jvm_memory_used_bytes{member=\"$member\", id=~\"$jvm_memory_pool_heap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "used",
	              "metric": "",
	              "refId": "A",
	              "step": 1800
	            },
	            {
	              "expr": "jvm_memory_committed_bytes{member=\"$member\", id=~\"$jvm_memory_pool_heap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "commited",
	              "metric": "",
	              "refId": "B",
	              "step": 1800
	            },
	            {
	              "expr": "jvm_memory_max_bytes{member=\"$member\", id=~\"$jvm_memory_pool_heap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "max",
	              "metric": "",
	              "refId": "C",
	              "step": 1800
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "$jvm_memory_pool_heap",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "mbytes",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "format": "bytes",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        }
	      ],
	      "repeat": "persistence_counts",
	      "title": "JVM Memory Pools (Heap)",
	      "type": "row"
	    },
	    {
	      "collapsed": true,
	      "gridPos": {
	        "h": 1,
	        "w": 24,
	        "x": 0,
	        "y": 15
	      },
	      "id": 130,
	      "panels": [
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 8,
	            "x": 0,
	            "y": 9
	          },
	          "id": 78,
	          "legend": {
	            "alignAsTable": false,
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "rightSide": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "maxPerRow": 3,
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "repeat": "jvm_memory_pool_nonheap",
	          "scopedVars": {
	            "jvm_memory_pool_nonheap": {
	              "selected": false,
	              "text": "Metaspace",
	              "value": "Metaspace"
	            }
	          },
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "jvm_memory_used_bytes{member=\"$member\", id=~\"$jvm_memory_pool_nonheap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "used",
	              "metric": "",
	              "refId": "A",
	              "step": 1800
	            },
	            {
	              "expr": "jvm_memory_committed_bytes{member=\"$member\", id=~\"$jvm_memory_pool_nonheap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "commited",
	              "metric": "",
	              "refId": "B",
	              "step": 1800
	            },
	            {
	              "expr": "jvm_memory_max_bytes{member=\"$member\", id=~\"$jvm_memory_pool_nonheap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "max",
	              "metric": "",
	              "refId": "C",
	              "step": 1800
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "$jvm_memory_pool_nonheap",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "mbytes",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "format": "bytes",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 8,
	            "x": 8,
	            "y": 9
	          },
	          "id": 156,
	          "legend": {
	            "alignAsTable": false,
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "rightSide": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "maxPerRow": 3,
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "repeat": null,
	          "repeatIteration": 1572465216002,
	          "repeatPanelId": 78,
	          "scopedVars": {
	            "jvm_memory_pool_nonheap": {
	              "selected": false,
	              "text": "Compressed Class Space",
	              "value": "Compressed Class Space"
	            }
	          },
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "jvm_memory_used_bytes{member=\"$member\", id=~\"$jvm_memory_pool_nonheap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "used",
	              "metric": "",
	              "refId": "A",
	              "step": 1800
	            },
	            {
	              "expr": "jvm_memory_committed_bytes{member=\"$member\", id=~\"$jvm_memory_pool_nonheap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "commited",
	              "metric": "",
	              "refId": "B",
	              "step": 1800
	            },
	            {
	              "expr": "jvm_memory_max_bytes{member=\"$member\", id=~\"$jvm_memory_pool_nonheap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "max",
	              "metric": "",
	              "refId": "C",
	              "step": 1800
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "$jvm_memory_pool_nonheap",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "mbytes",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "format": "bytes",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 8,
	            "x": 16,
	            "y": 9
	          },
	          "id": 157,
	          "legend": {
	            "alignAsTable": false,
	            "avg": false,
	            "current": true,
	            "max": true,
	            "min": false,
	            "rightSide": false,
	            "show": true,
	            "total": false,
	            "values": true
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "maxPerRow": 3,
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "repeat": null,
	          "repeatIteration": 1572465216002,
	          "repeatPanelId": 78,
	          "scopedVars": {
	            "jvm_memory_pool_nonheap": {
	              "selected": false,
	              "text": "Code Cache",
	              "value": "Code Cache"
	            }
	          },
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "jvm_memory_used_bytes{member=\"$member\", id=~\"$jvm_memory_pool_nonheap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "used",
	              "metric": "",
	              "refId": "A",
	              "step": 1800
	            },
	            {
	              "expr": "jvm_memory_committed_bytes{member=\"$member\", id=~\"$jvm_memory_pool_nonheap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "commited",
	              "metric": "",
	              "refId": "B",
	              "step": 1800
	            },
	            {
	              "expr": "jvm_memory_max_bytes{member=\"$member\", id=~\"$jvm_memory_pool_nonheap\"}",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "max",
	              "metric": "",
	              "refId": "C",
	              "step": 1800
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "$jvm_memory_pool_nonheap",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "mbytes",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "format": "bytes",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        }
	      ],
	      "repeat": null,
	      "title": "JVM Memory Pools (Non-Heap)",
	      "type": "row"
	    },
	    {
	      "collapsed": true,
	      "gridPos": {
	        "h": 1,
	        "w": 24,
	        "x": 0,
	        "y": 16
	      },
	      "id": 131,
	      "panels": [
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "fill": 1,
	          "gridPos": {
	            "h": 7,
	            "w": 8,
	            "x": 0,
	            "y": 10
	          },
	          "id": 98,
	          "legend": {
	            "avg": false,
	            "current": false,
	            "max": false,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": false
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "rate(jvm_gc_pause_seconds_count{cluster=\"$cluster_id\",member=\"$member\"}[1m])",
	              "format": "time_series",
	              "hide": false,
	              "intervalFactor": 2,
	              "legendFormat": "{{action}} ({{cause}})",
	              "refId": "A"
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Collections",
	          "tooltip": {
	            "shared": true,
	            "sort": 0,
	            "value_type": "individual"
	          },
	          "type": "graph",
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "yaxes": [
	            {
	              "format": "ops",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": "0",
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": "",
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "fill": 1,
	          "gridPos": {
	            "h": 7,
	            "w": 8,
	            "x": 8,
	            "y": 10
	          },
	          "id": 101,
	          "legend": {
	            "avg": false,
	            "current": false,
	            "max": false,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": false
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "rate(jvm_gc_pause_seconds_sum{cluster=\"$cluster_id\",member=\"$member\"}[1m])/rate(jvm_gc_pause_seconds_count{cluster=\"$cluster_id\",member=\"$member\"}[1m])",
	              "format": "time_series",
	              "hide": false,
	              "instant": false,
	              "intervalFactor": 1,
	              "legendFormat": "avg {{action}} ({{cause}})",
	              "refId": "A"
	            },
	            {
	              "expr": "jvm_gc_pause_seconds_max{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "hide": false,
	              "instant": false,
	              "intervalFactor": 1,
	              "legendFormat": "max {{action}} ({{cause}})",
	              "refId": "B"
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Pause Durations",
	          "tooltip": {
	            "shared": true,
	            "sort": 0,
	            "value_type": "individual"
	          },
	          "type": "graph",
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "yaxes": [
	            {
	              "format": "s",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": "0",
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": "",
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "fill": 1,
	          "gridPos": {
	            "h": 7,
	            "w": 8,
	            "x": 16,
	            "y": 10
	          },
	          "id": 99,
	          "legend": {
	            "avg": false,
	            "current": false,
	            "max": false,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": false
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "rate(jvm_gc_memory_allocated_bytes_total{cluster=\"$cluster_id\",member=\"$member\"}[1m])",
	              "format": "time_series",
	              "interval": "",
	              "intervalFactor": 1,
	              "legendFormat": "allocated",
	              "refId": "A"
	            },
	            {
	              "expr": "rate(jvm_gc_memory_promoted_bytes_total{cluster=\"$cluster_id\",member=\"$member\"}[1m])",
	              "format": "time_series",
	              "interval": "",
	              "intervalFactor": 1,
	              "legendFormat": "promoted",
	              "refId": "B"
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Allocated/Promoted",
	          "tooltip": {
	            "shared": true,
	            "sort": 0,
	            "value_type": "individual"
	          },
	          "type": "graph",
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "yaxes": [
	            {
	              "format": "Bps",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": "0",
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        }
	      ],
	      "repeat": null,
	      "title": "Garbage Collection",
	      "type": "row"
	    },
	    {
	      "collapsed": true,
	      "gridPos": {
	        "h": 1,
	        "w": 24,
	        "x": 0,
	        "y": 17
	      },
	      "id": 132,
	      "panels": [
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 12,
	            "x": 0,
	            "y": 46
	          },
	          "id": 37,
	          "legend": {
	            "avg": false,
	            "current": false,
	            "max": false,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": false
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "jvm_classes_loaded{cluster=\"$cluster_id\",member=\"$member\"} or jvm_classes_loaded_classes{cluster=\"$cluster_id\",member=\"$member\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "loaded",
	              "metric": "",
	              "refId": "A",
	              "step": 1200
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Classes loaded",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "short",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 12,
	            "x": 12,
	            "y": 46
	          },
	          "id": 38,
	          "legend": {
	            "avg": false,
	            "current": false,
	            "max": false,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": false
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "delta(jvm_classes_loaded{application=\"$application\",instance=\"$instance\"}[5m]) or delta(jvm_classes_loaded_classes{application=\"$application\",instance=\"$instance\"}[5m])",
	              "format": "time_series",
	              "hide": false,
	              "interval": "",
	              "intervalFactor": 2,
	              "legendFormat": "delta",
	              "metric": "",
	              "refId": "A",
	              "step": 1200
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Class delta (5m)",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "ops",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "decimals": null,
	              "format": "short",
	              "label": "",
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        }
	      ],
	      "repeat": null,
	      "title": "Classloading",
	      "type": "row"
	    },
	    {
	      "collapsed": true,
	      "gridPos": {
	        "h": 1,
	        "w": 24,
	        "x": 0,
	        "y": 18
	      },
	      "id": 133,
	      "panels": [
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 6,
	            "x": 0,
	            "y": 26
	          },
	          "id": 33,
	          "legend": {
	            "avg": false,
	            "current": false,
	            "max": false,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": false
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "jvm_buffer_memory_used_bytes{member=\"$member\", id=\"direct\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "used",
	              "metric": "",
	              "refId": "A",
	              "step": 2400
	            },
	            {
	              "expr": "jvm_buffer_total_capacity_bytes{member=\"$member\", id=\"direct\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "capacity",
	              "metric": "",
	              "refId": "B",
	              "step": 2400
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Direct Buffers",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "short",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "format": "bytes",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 6,
	            "x": 6,
	            "y": 26
	          },
	          "id": 83,
	          "legend": {
	            "avg": false,
	            "current": false,
	            "max": false,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": false
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "jvm_buffer_count{member=\"$member\", id=\"direct\"} or jvm_buffer_count_buffers{member=\"$member\", id=\"direct\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "count",
	              "metric": "",
	              "refId": "A",
	              "step": 2400
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Direct Buffers",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "short",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "decimals": 0,
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 6,
	            "x": 12,
	            "y": 26
	          },
	          "id": 85,
	          "legend": {
	            "avg": false,
	            "current": false,
	            "max": false,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": false
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "jvm_buffer_memory_used_bytes{member=\"$member\", id=\"mapped\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "used",
	              "metric": "",
	              "refId": "A",
	              "step": 2400
	            },
	            {
	              "expr": "jvm_buffer_total_capacity_bytes{member=\"$member\", id=\"mapped\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "capacity",
	              "metric": "",
	              "refId": "B",
	              "step": 2400
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Mapped Buffers",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "short",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "format": "bytes",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        },
	        {
	          "aliasColors": {},
	          "bars": false,
	          "dashLength": 10,
	          "dashes": false,
	          "datasource": "${DS_PROMETHEUS}",
	          "editable": true,
	          "error": false,
	          "fill": 1,
	          "grid": {
	            "leftLogBase": 1,
	            "leftMax": null,
	            "leftMin": null,
	            "rightLogBase": 1,
	            "rightMax": null,
	            "rightMin": null
	          },
	          "gridPos": {
	            "h": 7,
	            "w": 6,
	            "x": 18,
	            "y": 26
	          },
	          "id": 84,
	          "legend": {
	            "avg": false,
	            "current": false,
	            "max": false,
	            "min": false,
	            "show": true,
	            "total": false,
	            "values": false
	          },
	          "lines": true,
	          "linewidth": 1,
	          "links": [],
	          "nullPointMode": "null",
	          "percentage": false,
	          "pointradius": 5,
	          "points": false,
	          "renderer": "flot",
	          "seriesOverrides": [],
	          "spaceLength": 10,
	          "stack": false,
	          "steppedLine": false,
	          "targets": [
	            {
	              "expr": "jvm_buffer_count{member_name=\"$member\", id=\"mapped\"} or jvm_buffer_count_buffers{member_name=\"$member\", id=\"mapped\"}",
	              "format": "time_series",
	              "intervalFactor": 2,
	              "legendFormat": "count",
	              "metric": "",
	              "refId": "A",
	              "step": 2400
	            }
	          ],
	          "thresholds": [],
	          "timeFrom": null,
	          "timeRegions": [],
	          "timeShift": null,
	          "title": "Mapped Buffers",
	          "tooltip": {
	            "msResolution": false,
	            "shared": true,
	            "sort": 0,
	            "value_type": "cumulative"
	          },
	          "type": "graph",
	          "x-axis": true,
	          "xaxis": {
	            "buckets": null,
	            "mode": "time",
	            "name": null,
	            "show": true,
	            "values": []
	          },
	          "y-axis": true,
	          "y_formats": [
	            "short",
	            "short"
	          ],
	          "yaxes": [
	            {
	              "decimals": 0,
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": 0,
	              "show": true
	            },
	            {
	              "format": "short",
	              "label": null,
	              "logBase": 1,
	              "max": null,
	              "min": null,
	              "show": true
	            }
	          ],
	          "yaxis": {
	            "align": false,
	            "alignLevel": null
	          }
	        }
	      ],
	      "repeat": null,
	      "title": "Buffer Pools",
	      "type": "row"
	    }
	  ],
	  "refresh": "5s",
	  "schemaVersion": 18,
	  "style": "dark",
	  "tags": [],
	  "templating": {
	    "list": [
	      {
	        "allValue": null,
	        "current": {},
	        "datasource": "${DS_PROMETHEUS}",
	        "definition": "label_values(cluster)",
	        "hide": 0,
	        "includeAll": false,
	        "label": "cluster",
	        "multi": false,
	        "name": "cluster_id",
	        "options": [],
	        "query": "label_values(cluster)",
	        "refresh": 2,
	        "regex": "",
	        "skipUrlSync": false,
	        "sort": 3,
	        "tagValuesQuery": "",
	        "tags": [],
	        "tagsQuery": "",
	        "type": "query",
	        "useTags": false
	      },
	      {
	        "allValue": null,
	        "current": {},
	        "datasource": "${DS_PROMETHEUS}",
	        "definition": "label_values({cluster=\"$cluster_id\"}, member)",
	        "hide": 0,
	        "includeAll": false,
	        "label": "member",
	        "multi": false,
	        "name": "member",
	        "options": [],
	        "query": "label_values({cluster=\"$cluster_id\"}, member)",
	        "refresh": 2,
	        "regex": "",
	        "skipUrlSync": false,
	        "sort": 1,
	        "tagValuesQuery": "",
	        "tags": [],
	        "tagsQuery": "",
	        "type": "query",
	        "useTags": false
	      },
	      {
	        "allFormat": "glob",
	        "allValue": null,
	        "current": {},
	        "datasource": "${DS_PROMETHEUS}",
	        "definition": "label_values(jvm_memory_used_bytes{member=\"$member\", area=\"heap\"},id)",
	        "hide": 0,
	        "includeAll": true,
	        "label": "JVM Memory Pools Heap",
	        "multi": false,
	        "multiFormat": "glob",
	        "name": "jvm_memory_pool_heap",
	        "options": [],
	        "query": "label_values(jvm_memory_used_bytes{member=\"$member\", area=\"heap\"},id)",
	        "refresh": 1,
	        "regex": "",
	        "skipUrlSync": false,
	        "sort": 1,
	        "tagValuesQuery": "",
	        "tags": [],
	        "tagsQuery": "",
	        "type": "query",
	        "useTags": false
	      },
	      {
	        "allFormat": "glob",
	        "allValue": null,
	        "current": {},
	        "datasource": "${DS_PROMETHEUS}",
	        "definition": "label_values(jvm_memory_used_bytes{member=\"$member\", area=\"nonheap\"},id)",
	        "hide": 0,
	        "includeAll": true,
	        "label": "JVM Memory Pools Non-Heap",
	        "multi": false,
	        "multiFormat": "glob",
	        "name": "jvm_memory_pool_nonheap",
	        "options": [],
	        "query": "label_values(jvm_memory_used_bytes{member=\"$member\", area=\"nonheap\"},id)",
	        "refresh": 1,
	        "regex": "",
	        "skipUrlSync": false,
	        "sort": 2,
	        "tagValuesQuery": "",
	        "tags": [],
	        "tagsQuery": "",
	        "type": "query",
	        "useTags": false
	      }
	    ]
	  },
	  "time": {
	    "from": "now-24h",
	    "to": "now"
	  },
	  "timepicker": {
	    "now": true,
	    "refresh_intervals": [
	      "2s",
	      "10s",
	      "30s",
	      "1m",
	      "5m",
	      "15m",
	      "30m",
	      "1h",
	      "2h",
	      "1d"
	    ],
	    "time_options": [
	      "5m",
	      "15m",
	      "1h",
	      "6h",
	      "12h",
	      "24h",
	      "2d",
	      "7d",
	      "30d"
	    ]
	  },
	  "timezone": "browser",
	  "title": "GemFire Member Level Metrics",
	  "uid": "f0jxHSvWk",
	  "version": 69
	}
	EOF
}
