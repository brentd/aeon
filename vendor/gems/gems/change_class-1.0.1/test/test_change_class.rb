require 'test/unit'
require 'change_class'

class X
  def thingy
    1
  end
end

class Y
  def thingy
    2
  end
end

class Thing
  attr_accessor :name
end

class TestChangeClass < Test::Unit::TestCase
  def test_change_class
    x = X.new
    assert_equal X, x.class
    assert_equal 1, x.thingy

    x.class = Y
    assert_equal Y, x.class
    assert_equal 2, x.thingy
  end

  def test_change_class_bork_bork_bork
    t = Thing.new
    t.name = "Monkeyfucker"
    assert_equal "Monkeyfucker", t.name

    t.class = Y
    assert_raises NoMethodError do
      t.name
    end
  end
end
