#!/usr/bin/env python3
"""
12. Log stats
"""
from pymongo import MongoClient

if __name__ == "__main__":
    client = MongoClient('mongodb://127.0.0.1:27017')
    nginx_collection = client.logs.nginx
    methods = ["GET", "POST", "PUT", "PATCH", "DELETE"]
    print(f'{nginx_collection.count_documents({})} logs')
    print('Methods:')
    for method in methods:
        filter = {"$and": [{"method": method}, {"path": "/status"}]}
        count = nginx_collection.count_documents(filter)
        print(f'\tmethod {method}: {count}')
