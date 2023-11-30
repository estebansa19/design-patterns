=begin

Context

The Singleton pattern solves two problems at the same time, violating the Single Responsability
Principle:

1. Ensure that a class has just a single instance: the most common reason for this is controling
the access to some shared resource, for example, a database or a file.

The idea is that the class always return the same instance.

This behavior is impossible to implement with a regular constructor since a constructor must always
return a new object by design.

2. Provide a global access point to that instance: just like a global variable, the Singleton
pattern lets you access some object from anywhere in the program. However, it also protects that
instance from being overwritten by other code.

=end
