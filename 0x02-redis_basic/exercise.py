#!/usr/bin/env python3
"""
Writing strings to Redis
"""
import redis
from uuid import uuid1
from typing import Union


class Cache:
    """
    class represents cache memory
    """
    def __init__(self):
        """
        inictantiation method
        """
        self._redis = redis.Redis(host='localhost', port=6379, db=0)
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        """
        store the input data in Redis using the random key and return the key
        """
        key = str(uuid1())
        self._redis.set(key, data)
        return key
