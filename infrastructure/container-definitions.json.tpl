[
    {
        "name": "${aws_container_name}",
        "image": "${aws_ecr_image}",
        "essential": true,
        "portMappings": [
            {
                "containerPort": 80,
                "hostPort": 80
            }
        ],
        "memoryReservation": 512,
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group_name}",
                "awslogs-region": "${log_group_region}",
                "awslogs-stream-prefix": "${aws_container_name}"
            }
        },
        "mountPoints": [
            {
                "readOnly": true,
                "containerPath": "/vol/static",
                "sourceVolume": "static"
            }
        ]
    }
]
