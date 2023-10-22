#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import json

print(
    json.dumps(
        {
            "_meta": {
              "hostvars": {
                "reddit-app": {
                  "ansible_host": "84.201.128.233"
                },
                "reddit-db": {
                  "ansible_host": "62.84.116.43"
                }
              }
            },
            "all": {
              "children": [
                "app",
                "db"
              ]
            },
            "app": {
              "hosts": ["reddit-app"]
            },
            "db": {
              "hosts": ["reddit-db"]
            }
        }
    )
)
