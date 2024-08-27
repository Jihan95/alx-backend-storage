#!/usr/bin/env python3
""" a Python function that lists all documents in a collection"""


def list_all(mongo_collection: Collection) -> List[Dict[str, Any]]:
    """
     List all documents in Python
    """
    if mongo_collection.count_documents({}) == 0:
        return []
    docs = mongo_collection.find()
    return docs
