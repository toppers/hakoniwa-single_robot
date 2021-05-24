{
    "core_ipaddr": "{{RESOLVE_IPADDR}}",
    "core_portno": 50051,
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
        },
        {
            "name": "RoboModel_ComConverter",
            "pdu_writer_names": [
                "RoboModel_Ev3SensorPdu",
                "RoboModel_Ev3SensorProtobufPdu",
            ],
            "pdu_reader_names": [
                "RoboModel_Ev3ActuatorPdu",
                "RoboModel_Ev3ActuatorProtobufPdu",
            ],
	    "core_class_name": "Ev3ProtobufConverter"
        },
    ],
    "outside_assets": [
        {
            "name": "Athrill",
            "class_name": "Ev3MiconAssetController"
        }
    ],
    "pdu_writers": [
        {
            "name": "RoboModel_Ev3SensorPdu",
            "class_name": "Ev3PduWriter"
        },
        {
            "name": "RoboModel_Ev3SensorProtobufPdu",
            "class_name": "Ev3PduProtobufWriter"
        }
    ],
    "pdu_readers": [
        {
            "name": "RoboModel_Ev3ActuatorPdu",
            "class_name": "Ev3PduReader"
        },
        {
            "name": "RoboModel_Ev3ActuatorProtobufPdu",
            "class_name": "Ev3PduProtobufReader"
        }
    ],
    "udp_methods": [
        {
            "method_name": "UdpMethod3",
            "ipaddr": "127.0.0.1",
            "portno": 54003,
            "iosize": 1024,
            "is_read": false
        },
        {
            "method_name": "UdpMethod4",
            "ipaddr": "127.0.0.1",
            "portno": 54004,
            "iosize": 1024,
            "is_read": false
        }
    ],
    "mmap_methods": [
	{
            "method_name": "MmapMethod1",
            "filepath": "{{APL_PROJECT_PATH}}/unity_mmap.bin",
            "iosize": 1024,
            "is_read": false
	},
	{
            "method_name": "MmapMethod2",
            "filepath": "{{APL_PROJECT_PATH}}/athrill_mmap.bin",
            "iosize": 1024,
            "is_read": true
	},
    ],
    "reader_connectors": [
        {
            "name": "reader_connector1",
            "pdu_name": "RoboModel_Ev3ActuatorPdu",
            "method_name": "MmapMethod2"
        }
    ],
    "writer_connectors": [
        {
            "name": "writer_connector1",
            "pdu_name": "RoboModel_Ev3SensorPdu",
            "method_name": "MmapMethod1"
        },
        {
            "name": "writer_connector2",
            "pdu_name": "RoboModel_Ev3SensorProtobufPdu",
            "method_name": "UdpMethod3"
        },
        {
            "name": "writer_connector3",
            "pdu_name": "RoboModel_Ev3ActuatorProtobufPdu",
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
        },
    ]
}
