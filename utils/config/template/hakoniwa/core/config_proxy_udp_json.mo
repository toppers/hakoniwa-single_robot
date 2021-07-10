{
    "core_ipaddr": "{{RESOLVE_IPADDR}}",
    "core_portno": {{CORE_PORTNO}},
    "asset_timeout": 3,
    "SymTimeMeasureFilePath": null,
    "inside_assets": [
        {
            "name": "RoboModel",
            "pdu_writer_names": [
                "RoboModel_Ev3SensorPdu"
            ],
            "pdu_reader_names": [
                "RoboModel_Ev3ActuatorPdu",
            ]
        }
    ],
    "outside_assets": [
        {
            "name": "Athrill",
            "class_name": "Hakoniwa.PluggableAsset.Assets.Micon.EV3.Ev3MiconAssetController"
        }
    ],
    "pdu_writers": [
        {
            "name": "RoboModel_Ev3SensorPdu",
            "class_name": "Hakoniwa.PluggableAsset.Communication.Pdu.Ev3.Ev3PduWriter",
            "conv_class_name" : "Hakoniwa.PluggableAsset.Communication.Pdu.Ev3.Ev3PduWriter{{PACKET_TYPE}}Converter",
            "pdu_config_name": "Ev3PduSensor",
        }
    ],
    "pdu_readers": [
        {
            "name": "RoboModel_Ev3ActuatorPdu",
            "class_name": "Hakoniwa.PluggableAsset.Communication.Pdu.Ev3.Ev3PduReader",
            "conv_class_name" : "Hakoniwa.PluggableAsset.Communication.Pdu.Ev3.Ev3PduReader{{PACKET_TYPE}}Converter",
            "pdu_config_name": "Ev3PduAcuator",
        }
    ],
    "pdu_configs": [
        {
            "pdu_type_name": "Ev3PduAcuator",
			"pdu_data_field_path" : "./pdu/Ev3PduAcuator.json"
        },
        {
            "pdu_type_name": "Ev3PduSensor",
			"pdu_data_field_path" : "./pdu/Ev3PduSensor.json"
        },
        {
            "pdu_type_name": "Ev3PduAcuatorHeader",
			"pdu_data_field_path" : "./pdu/Ev3PduAcuatorHeader.json"
        },
        {
            "pdu_type_name": "Ev3PduColorSensor",
			"pdu_data_field_path" : "./pdu/Ev3PduColorSensor.json"
        },
        {
            "pdu_type_name": "Ev3PduMotor",
			"pdu_data_field_path" : "./pdu/Ev3PduMotor.json"
        },
        {
            "pdu_type_name": "Ev3PduSensorHeader",
			"pdu_data_field_path" : "./pdu/Ev3PduSensorHeader.json"
        },
        {
            "pdu_type_name": "Ev3PduTouchSensor",
			"pdu_data_field_path" : "./pdu/Ev3PduTouchSensor.json"
        },
    ],    
    "udp_methods": [
        {
            "method_name": "UdpMethod1",
            "ipaddr": "{{IFCONFIG_IPADDR}}",
            "portno": 54002,
            "iosize": 1024,
            "is_read": false
        },
        {
            "method_name": "UdpMethod2",
            "ipaddr": "{{RESOLVE_IPADDR}}",
            "portno": 54001,
            "iosize": 1024,
            "is_read": true
        },
        {
            "method_name": "UdpMethod3",
            "ipaddr": "{{IFCONFIG_IPADDR}}",
            "portno": 54003,
            "iosize": 1024,
            "is_read": false
        },
        {
            "method_name": "UdpMethod4",
            "ipaddr": "{{IFCONFIG_IPADDR}}",
            "portno": 54004,
            "iosize": 1024,
            "is_read": false
        }
    ],
    "mmap_methods": null,
    "reader_connectors": [
        {
            "name": "reader_connector1",
            "pdu_name": "RoboModel_Ev3ActuatorPdu",
            "method_name": "UdpMethod2"
        }
    ],
    "writer_connectors": [
        {
            "name": "writer_connector1",
            "pdu_name": "RoboModel_Ev3SensorPdu",
            "method_name": "UdpMethod1"
        },
        {
            "name": "writer_connector2",
            "pdu_name": "RoboModel_Ev3SensorPdu",
            "method_name": "UdpMethod3"
        },
        {
            "name": "writer_connector3",
            "pdu_name": "RoboModel_Ev3ActuatorPdu",
            "method_name": "UdpMethod4"
        }
    ],
    "pdu_channel_connectors": [
        {
            "outside_asset_name": "Athrill",
            "reader_connector_name": "reader_connector1",
            "writer_connector_name": "writer_connector1"
        },
        {
            "outside_asset_name": null,
            "reader_connector_name": null,
            "writer_connector_name": "writer_connector2"
        },
        {
            "outside_asset_name": null,
            "reader_connector_name": null,
            "writer_connector_name": "writer_connector3"
        }
    ]
}
