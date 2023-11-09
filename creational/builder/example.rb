=begin

Context

Imagine a complext object that requires laborious step-by-step initialization of many fields and
nested objects. Usually, this initialization is into a monstrous constructor with lots of params.
Or even worse, scattered all over the client code.

Let's think about making a cake. A simple cake would have: biscuit, buttercream and fondand. But
what if you want a bigger cake, with custom images, with custom fonts, with different kind of
flavors and other specifications?

The easiest solution is to extend the base Cake and create a set of subclasses to cover all
combinations of parameters. The problem is that, eventually you will end up with a considerable
number of subclasses. Any new paramater will require growing up this herarchy. Besides, imagine
having to modify a huge amount of subclasses due to a refactor.

Another approach will be to create a giant constructor in the base Cake class, with all possible
parameters that control the creation of a cake. While this approach indeed eliminates the need of
subclasses, it adds another problem. In most cases, most of the parameters will be unused, making
the constructor calls pretty confusing and ugly. For instance, just a fraction of the cakes have
custom images, so the parameters related to custom images will be useless nine times out of ten.



Solution

The Builder pattern suggests that you extract the object construction code out of its own class and
move it to separate objects called builders.

The pattern organizes the object creation into a set of steps (build_biscuit, build_buttercream,
etc). To create an object you just execute a series of these steps on a builder object. The
important part is that you don't need to call all of the steps, you only call the steps required to
the object that you want to build.

Some of the construction steps might require a different implementation when you need to build
various representations of the product. For instance, vanilla buttercream is made with vanilla but
chocolate buttercream must be made with chocolate. In this case we can create several different
builder classes that implement the same set of builder steps, but in a different manner. Then you
can call these builders in the construction process. For example, there could be a builder for
vanilla cakes, a second one for strawberry cakes and a third one that makes chocolate cakes.

You can go further and extract a series of calls to the builder steps to create a object into a
separate class called director. The director class defines the order of execution of the building
steps, while the builder provides the definition for those steps. However, it is not strictly
necessary to have a director but it might be a good place to put various construction routines.



Applicability

- Use the Builder pattern to get rid of a "telescoping constructor". This pattern allows us to get
  rid of a giant constructor, for example a constructor with the or more optional parameters. The
  Builder pattern let's you build the object step by step, using only those steps that you really
  need.

- Use the Builder pattern when you want to be able to create different versions of an object. This
  pattern can be applied when you want to create some similar objects that differ only in the
  details.

- Use the Builder to construct complex objects. This pattern let you construct objects step by
  step, you could defer the execution of some steps without breaking the final object.



Pros

- You can construct objects step by step, defer construction steps or execute steps recursively.

- You can reuse the same construction code when building different types of objects.

- Single Responsability Principle. You are isolating complex code construction from the business
  logic of the product.



Cons

- The overall complexity of the code increases since the pattern requires creating multiple classes.

=end

class Cake
  def initialize
    @cake_details = []
  end

  def add(detail)
    @cake_details << detail
  end

  def list_cake_details
    puts "Cake details: #{@cake_details.join(', ')}"
  end
end

class CakeBuilder
  def build_biscuit(size:)
    raise NotImplementedError, "#{self.class} has not implemented method #{__method__}"
  end

  def build_buttercream(flavor:, sugar:)
    raise NotImplementedError, "#{self.class} has not implemented method #{__method__}"
  end

  def build_fondand(flavor:, style:)
    raise NotImplementedError, "#{self.class} has not implemented method #{__method__}"
  end
end

class ChocolateCakeBuilder < CakeBuilder
  def initialize
    @cake = Cake.new
  end

  def cake
    cake = @cake
    @cake = Cake.new

    cake
  end

  def build_biscuit
    @cake.add(:big_biscuit)
  end

  def build_buttercream
    @cake.add(:nutella_buttercream)
  end

  def build_fondand
    @cake.add(:simple_fondand)
  end
end

class CakeDirector
  attr_accessor :cake_builder

  def initialize(cake_builder)
    @cake_builder = cake_builder
  end

  def build_minimal_viable_cake
    cake_builder.build_biscuit
  end

  def build_full_featured_cake
    cake_builder.build_biscuit
    cake_builder.build_buttercream
    cake_builder.build_fondand
  end
end

builder = ChocolateCakeBuilder.new
director = CakeDirector.new(builder)

puts 'Basic cake:'
director.build_minimal_viable_cake
puts builder.cake.list_cake_details

puts "\n\n"

puts 'Full built cake:'
director.build_full_featured_cake
puts builder.cake.list_cake_details

# We can use this pattern without a director class
builder.build_biscuit
builder.build_buttercream
builder.build_fondand
builder.cake.list_cake_details
