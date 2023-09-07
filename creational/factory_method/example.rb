=begin

Context

Imagine you're creating an application for a shoes store. The first version of our application can
handle shoes' shipment with only one carrier, DHL. Therefore, the bulk of our code lives inside the
DHL class (communication, authentication, etc).

After a while, you're store becomes pretty popular. Each day you receive a lot of offers from other
carrier to integrate it into the application, FEDEX.

Pretty good news, aren't they? But what about the code? Most of our code is coupled to the DHL
class. Adding another FEDEX into the app would required making changes to the entire codebase.
Besides, if later you decide to integrate another carrier company to the application, you'll
probably have to make all of these changes again.

As a result, you'll end up with pretty nasty code, riddled with conditionals that switch the app's
behavior depending on the class of shoes shipment.



Solution

The Factory Method pattern suggests that you replace direct object constructions calls (.new) with
calls to a special factory method. Objects are still being created with the .new operator, but that
happens inside the factory method. Objects returned by a factory method are often referred to as products.

At first glance, this change may look pointless, we just some code from one part of the program to
another. However, now we can overwrite the factory method in a subclass and change the logic
according to the class of products bein created by this subclass.

There's a sligh limitation: subclass may return different types of products, but these products
should have a base common class or interface.



Applicability

- Use the Factory Method when you don't know beforehand the exact types and dependencies of the
objects you code should work with. For example, to add a new product type to the app, you'll only
need to create a new creator subclass and overwrite the factory method in it.

=end
