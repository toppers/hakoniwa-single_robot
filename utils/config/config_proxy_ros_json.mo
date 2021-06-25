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
                "EV3RoboModel_RosTopicWriterPdu"
            ],
            "pdu_reader_names": [
                "EV3RoboModel_Ev3ActuatorPdu",
            ]
        },
    ],
    "outside_assets": [
        {
            "name": "Athrill",
            "class_name": "Hakoniwa.PluggableAsset.Assets.Micon.EV3.Ev3MiconAssetController"
        },
    ],
    "pdu_writers": [
        {
            "name": "EV3RoboModel_Ev3SensorPdu",
            "class_name": "Hakoniwa.PluggableAsset.Communication.Pdu.Ev3.Ev3PduWriter",
            "conv_class_name" : "Hakoniwa.PluggableAsset.Communication.Pdu.Ev3.Ev3PduWriterProtobufConverter",
        },
        {
            "name": "EV3RoboModel_RosTopicWriterPdu",
            "class_name": "Hakoniwa.PluggableAsset.Communication.Pdu.ROS.RosTopicPduWriter",
            "conv_class_name" : "Hakoniwa.PluggableAsset.Communication.Pdu.ROS.RosTopicPduWriterConverter",
            "topic_message_name": "pos_rot",
            "pdu_config_name": "MRosRot_pdu_config",
        },
    ],
    "pdu_readers": [
        {
            "name": "EV3RoboModel_Ev3ActuatorPdu",
            "class_name": "Hakoniwa.PluggableAsset.Communication.Pdu.Ev3.Ev3PduReader",
            "conv_class_name" : "Hakoniwa.PluggableAsset.Communication.Pdu.Ev3.Ev3PduReaderProtobufConverter"
        },
    ],
    "pdu_configs": [
        {
            "pdu_config_name": "MRosRot_pdu_config",
            "fields": [
                {
                    "name": "pos_x",
                    "type": "float",
                }, 
                {
                    "name": "pos_y",
                    "type": "float",
                }, 
                {
                    "name": "pos_z",
                    "type": "float",
                }, 
                {
                    "name": "rot_x",
                    "type": "float",
                }, 
                {
                    "name": "rot_y",
                    "type": "float",
                }, 
                {
                    "name": "rot_z",
                    "type": "float",
                }, 
                {
                    "name": "rot_w",
                    "type": "float",
                }, 
            ],
        },
    ],
    "ros_topics": [
        {
            "topic_message_name": "pos_rot",
            "topic_type_name": "MRosRot",
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
    "ros_topic_method": 
    {
        "name": "ros_topic_io",
        "class_name": "Hakoniwa.PluggableAsset.Communication.Method.ROS.RosTopicIo",
    },
    "reader_connectors": [
        {
            "name": "reader_connector1",
            "pdu_name": "EV3RoboModel_Ev3ActuatorPdu",
            "method_name": "UdpMethod2"
        },
    ],
    "writer_connectors": [
        {
            "name": "writer_connector1",
            "pdu_name": "EV3RoboModel_Ev3SensorPdu",
            "method_name": "UdpMethod1"
        },
        {
            "name": "writer_connector2",
            "pdu_name": "EV3RoboModel_Ev3SensorPdu",
            "method_name": "UdpMethod3"
        },
        {
            "name": "writer_connector3",
            "pdu_name": "EV3RoboModel_Ev3ActuatorPdu",
            "method_name": "UdpMethod4"
        },
        {
            "name": "writer_connector_ros",
            "pdu_name": "EV3RoboModel_RosTopicWriterPdu",
            "method_name": "ros_topic_io"
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
        {
            "outside_asset_name": null,
            "reader_connector_name": null,
            "writer_connector_name": "writer_connector_ros"
        },
    ]
}