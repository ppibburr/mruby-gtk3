## Explicit declaration to use version 3.0
GirFFI.setup :Gtk, 3.0

## TODO: any version 3 specific handling.
##       Thus far I've not found any
Gtk

module Gtk
  # we're overiding Gtk::init
  # so we establish the method manually
  bind_module_function :init, f=find_function(:init)

  class << self
    # alias the bound `init`
    alias :_init_ :init
  end

  # overide Gtk::init
  #
  # @param argv Array<String> or nil, may be omitted from call
  def self.init argv=nil
    if argv
      return _init_(argv.length, argv)
    end
    
    return _init_(0,nil)
  end
end
