=begin

Context

Imagine you're creating an application for a shoes store. The first version of our application can
handle shoes' shipment with only one carrier, DHL. Therefore, the bulk of our code lives inside the
DHL class (communication, authentication, etc).

After a while, you're store becomes pretty popular. Each day you receive a lot of offers from other
carriers to integrate it into the application, FEDEX.

Pretty good news, aren't they? But what about the code? Most of our code is coupled to the DHL
class. Adding another carrier (FEDEX) into the app would required making changes to the entire codebase.
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

- Use the Factory Method when you want the users of your library or framework to be able to extend
  the behaviour of the internal components. They will have a way to override the default method
  definition and extend the component itself.

- Use the Factory Method when you want to save system resources by reusing existing objects instead
  of rebuilding them each time.

The constructor of a class will always return a new object, it can't return new existing instances.
Therefore, you need to have a regular method capable of creating new objects as well as reusing
existing ones, a factory method.



Pros

- You avoid tight coupling between the creator and the concrete products.

- Single Responsability. The creation of the object will be in one place in the program, making the
  code easier to support.

- Open/Closed. You can introduce new types of products into the program without breaking the
  existing client code.
=end

# Abstract class for the creator classes
class Creator
  def factory_method
    raise NotImplementedError, "#{self.class} has not implemented method #{__method__}"
  end

  def some_operation
    product = factory_method

    "Creator: the same creator's code has just worked with #{product.operation}"
  end
end

class DHLShipmentCreator < Creator
  def factory_method
    DHLShipment.new
  end
end

class FedexShipmentCreator < Creator
  def factory_method
    FedexShipment.new
  end
end

# Abstract class for the product classes
class Product
  def operation
    raise NotImplementedError, "#{self.class} has not implemented method #{__method__}"
  end
end

class DHLShipment < Product
  def operation
    text = <<~TEXT
      Authenticating with DHL
      ...
      Creating DHL shipment
      ...
      ...
      Success!

      TEXT
    puts text
  end
end

class FedexShipment < Product
  def operation
    text = <<~TEXT
      Authenticating with Fedex
      ...
      Creating Fedex shipment
      ...
      ...
      Success!

      TEXT
    puts text
  end
end

# Creating a new shipment for DHL
puts 'Creating a DHL shipment'
creator = DHLShipmentCreator.new
creator.some_operation

puts 'Creating a Fedex shipment'
creator = FedexShipmentCreator.new
creator.some_operation

