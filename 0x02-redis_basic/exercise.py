#!/usr/bin/env python3
"""
Writing strings to Redis
"""
import redis
from uuid import uuid1
from typing import Union, Callable, Optional
from functools import wraps


def count_calls(method: Callable) -> Callable:
    """
     increments the count for that key every time the method is
     called and returns the value returned by the original method.
    """
    @wraps(method)
    def wrapper(self, *args, **kwargs):
        key = method.__qualname__
        self._redis.incr(key)
        return method(self, *args, **kwargs)
    return wrapper


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

    @count_calls
    def store(self, data: Union[str, bytes, int, float]) -> str:
        """
        store the input data in Redis using the random key and return the key
        """
        key = str(uuid1())
        self._redis.set(key, data)
        return key

    def get(
            self,
            key: str,
            fn: Optional[
                Callable[[bytes], Optional[Union[str, int, float]]]] = None
            ) -> Optional[Union[str, bytes, int, float]]:
        """
        used to convert the data back to the desired format
        """
        data = self._redis.get(key)
        if data is None:
            return None
        if fn:
            return fn(data)
        return data

    def get_str(self, key: str) -> Optional[Union[str, bytes, float, None]]:
        """
        parametrize Cache.get
        """
        return self.get(key, lambda x: x.decode('utf-8') if x else None)

    def get_int(self, key: str) -> Optional[Union[str, bytes, float, None]]:
        """
        paarametrize Cache.get
        """
        return self.get(key, lambda x: int(x) if x else None)
