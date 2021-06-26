{
    "core_ipaddr": "{{RESOLVE_IPADDR}}",
    "core_portno": 50051,
    "asset_timeout": 3,
    "SymTimeMeasureFilePath": null,
    "inside_assets": [
        {
            "name": "EV3RoboModel",
            "pdu_writer_names": [
                "EV3RoboModel_Ev3SensorPdu",
            ],
            "pdu_reader_names": [
                "EV3RoboModel_Ev3ActuatorPdu",
            ]
        },
    ],
    "outside_assets": null,
    "pdu_writers": [
        {
            "name": "EV3RoboModel_Ev3SensorPdu",
            "class_name": "Hakoniwa.PluggableAsset.Communication.Pdu.ROS.RosTopicPduWriter",
            "conv_class_name" : "Hakoniwa.PluggableAsset.Communication.Pdu.ROS.RosTopicPduWriterConverter",
            "topic_message_name": "sensor",
            "pdu_config_name": "MSensor_pdu_config",
        },
    ],
    "pdu_readers": [
        {
            "name": "EV3RoboModel_Ev3ActuatorPdu",
            "class_name": "Hakoniwa.PluggableAsset.Communication.Pdu.ROS.RosTopicPduReader",
            "conv_class_name" : "Hakoniwa.PluggableAsset.Communication.Pdu.ROS.RosTopicPduReaderConverter",
            "topic_message_name": "actuator",
            "pdu_config_name": "MActuator_pdu_config",
        },
    ],
    "pdu_configs": [
        {
            "pdu_config_name": "MSensor_pdu_config",
            "fields": [
                {
                    "name": "button",
                    "type": "int8",
                }, 
                {
                    "name": "sensor_color0",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_color1",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_color2",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_reflect0",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_reflect1",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_reflect2",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_rgb_r0",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_rgb_r1",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_rgb_r2",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_rgb_g0",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_rgb_g1",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_rgb_g2",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_rgb_b0",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_rgb_b1",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_rgb_b2",
                    "type": "uint32",
                }, 
                {
                    "name": "sensor_gyroscope",
                    "type": "int32",
                }, 
                {
                    "name": "gyro_degree",
                    "type": "int32",
                }, 
                {
                    "name": "gyro_degree_rate",
                    "type": "int32",
                }, 
                {
                    "name": "sensor_ultrasonic",
                    "type": "uint32",
                }, 
                {
                    "name": "touch_sensor0",
                    "type": "uint32",
                }, 
                {
                    "name": "touch_sensor1",
                    "type": "uint32",
                }, 
                {
                    "name": "motor_angle_a",
                    "type": "uint32",
                }, 
                {
                    "name": "motor_angle_b",
                    "type": "uint32",
                }, 
                {
                    "name": "motor_angle_c",
                    "type": "uint32",
                }, 
                {
                    "name": "gps_lat",
                    "type": "float64",
                }, 
                {
                    "name": "gps_lon",
                    "type": "float64",
                }, 
            ],
        },
        {
            "pdu_config_name": "MActuator_pdu_config",
            "fields": [
                {
                    "name": "led",
                    "type": "int32",
                }, 
                {
                    "name": "motor_power_a",
                    "type": "int32",
                }, 
                {
                    "name": "motor_stop_a",
                    "type": "uint32",
                }, 
                {
                    "name": "motor_reset_angle_a",
                    "type": "uint32",
                }, 
                {
                    "name": "motor_power_b",
                    "type": "int32",
                }, 
                {
                    "name": "motor_stop_b",
                    "type": "uint32",
                }, 
                {
                    "name": "motor_reset_angle_b",
                    "type": "uint32",
                }, 
                {
                    "name": "motor_power_c",
                    "type": "int32",
                }, 
                {
                    "name": "motor_stop_c",
                    "type": "uint32",
                }, 
                {
                    "name": "motor_reset_angle_c",
                    "type": "uint32",
                }, 
                {
                    "name": "gyro_reset",
                    "type": "int32",
                }, 
            ],
        },
    ],
    "ros_topics": [
        {
            "topic_message_name": "sensor",
            "topic_type_name": "MSensor",
        },
        {
            "topic_message_name": "actuator",
            "topic_type_name": "MActuator",
        },
    ],
    "udp_methods": null,
    "mmap_methods": null,
    "ros_topic_method": 
    {
        "name": "ros_topic_io",
        "class_name": "Hakoniwa.PluggableAsset.Communication.Method.ROS.RosTopicIo",
    },
    "reader_connectors": [
        {
            "name": "reader_connector1",
            "pdu_name": "EV3RoboModel_Ev3ActuatorPdu",
            "method_name": "ros_topic_io"
        },
    ],
    "writer_connectors": [
        {
            "name": "writer_connector1",
            "pdu_name": "EV3RoboModel_Ev3SensorPdu",
            "method_name": "ros_topic_io"
        },
    ],
    "pdu_channel_connectors": [
        {
            "outside_asset_name": null,
            "reader_connector_name": null,
            "writer_connector_name": "writer_connector1"
        },
        {
            "outside_asset_name": null,
            "reader_connector_name": "reader_connector1",
            "writer_connector_name": null
        },
    ]
}