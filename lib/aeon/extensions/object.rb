class Object
  # [BD] I use the "display" as a method name for writing output to the client
  # throughout Aeon. Ruby implements Object#display, so I'm undefining it to
  # avoid any confusion. It's quite possible this will come back to haunt me
  # when I begin using a library that relies on this method, but so far I
  # haven't seen it used anywhere :)
  undef_method :display

  # @param name<String> The name of the constant to get, e.g. "Merb::Router".
  #
  # @return <Object> The constant corresponding to the name.
  def full_const_get(name)
    list = name.split("::")
    list.shift if list.first.blank?
    obj = self
    list.each do |x|
      # This is required because const_get tries to look for constants in the
      # ancestor chain, but we only want constants that are HERE
      obj = obj.const_defined?(x) ? obj.const_get(x) : obj.const_missing(x)
    end
    obj
  end

  # @param name<String> The name of the constant to get, e.g. "Merb::Router".
  # @param value<Object> The value to assign to the constant.
  #
  # @return <Object> The constant corresponding to the name.
  def full_const_set(name, value)
    list = name.split("::")
    toplevel = list.first.blank?
    list.shift if toplevel
    last = list.pop
    obj = list.empty? ? Object : Object.full_const_get(list.join("::"))
    obj.const_set(last, value) if obj && !obj.const_defined?(last)
  end
end