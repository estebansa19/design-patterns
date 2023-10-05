=begin

Context

Lets save you have an object and you want to make an exact copy of it. You will have to create an
object from the same class and go through all the fields of the original object and copy their
values over the new object.

We are good, but there's a catch. Not all object can be copied because some of the object's fields
may be private and not be visible from the outside of the object itself.

There's one more problem with this approach. Since we have to know the class of the object, our
code becomes dependent on that class, we are adding a dependency here. Besides, sometimes you only
know the interface that the object follows but not its concrete class.



Solution

This pattern delegates the cloning process to the actual objects that are being cloned, it's their
responsability. The pattern declares a common interface for all objects that support cloning. This
interface lets you clone an object without coupling all of the code to the class. Usually, this
interface contains only just a single .clone method.

The implementation of the .clone method is very similar in all clases. The method creates an object
of the current class and carries over all the field values of the old object into the new one. This
way, you can even copy private fields.

An object that supports cloning is called a prototype.

When your object has dozens of fields and hundreds of configurations, cloning them might serve as an
alternative to subclassing. The idea will be create a set of objects, configured in various ways and
when you need an object like the one you've configured, you just clone a prototype instead of
constructing a new object from scratch.



Applicability

- Use the Prototype Pattern when your code shouldn't depend on the concrete classes of objects that
  you need to copy. This patterns provides the cliend code with the interface for working with
  objects that support cloning. This interface makes the client code independent from the concrete
  classes of objects that it clones.

- Use the pattern when you want to reduce the number of subclasses that only differ in the way they
  initialize their respective objects. Imagine that we have a complex class that requires a
  laborious configuration before it can be used and there are several ways to configure this class.
  To reduce the duplication you've created a set of subclasses and put every common configuration
  into their constructors. You solved the duplication problem but now you have lots of dummy
  subclasses. This patterns lets you use a set of pre-built objects configured in various ways
  instead of instantiating a subclass that matches some configuration, the client can simply look
  for an appropiate prototype and clone it.



Pros and cons
=end
