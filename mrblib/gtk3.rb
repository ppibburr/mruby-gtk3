GirFFI::setup :Gtk#,'3.0'

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
  def self.init *o
    if o[0].is_a? Array
      argv = o[0]
    end
    
    if argv
      return _init_(argv.length, argv)
    end
    
    if o[0].is_a?(Integer) and o[1].is_a?(Array)
      return _init_(o[0], o[1])
    end
    
    return _init_(0,nil)
  end
  

  self::Lib.attach_function :gtk_list_store_set,[:pointer,:pointer,:int,:pointer,:int],:void
  self::Lib.attach_function :gtk_tree_model_get,[:pointer,:pointer,:int,:pointer,:int],:void
  
  Gtk::ListStore  
  class ListStore
    def set iter,col,v
      v = GirFFI::coerce_pointer(v)
      
      iter = GirFFI.coerce_pointer(iter)
      
      Gtk::Lib.gtk_list_store_set self.to_ptr, iter.to_out(true), col, v,-1
    end
    
    def self.newv *o
      self.new *o
    end   
  end
  
  module TreeModel
    def get iter,col
      iter = GirFFI::coerce_pointer(iter)
      v = FFI::MemoryPointer.new :pointer
      type = get_column_type(col)    
      Gtk::Lib.gtk_tree_model_get self.to_ptr, iter.to_out(true), col, v.to_out(true), -1
      return GirFFI::gtype_value2ruby(type,v)
    end
    
    bind_instance_method :get_value, i=find_function(:get_value)
    def get_value iter,col
      iter = GirFFI::coerce_pointer(iter)
      val = GObject::Value.new

      # BUG: bug in mruby likely... `g_value_init` from libgobject-2.0 will segfault
      #      so we init to the proper type ourselves, only throws a warning
      val.init get_column_type(col)

      Gtk::Lib.gtk_tree_model_get_value(self.to_ptr,iter.to_out(true),col,val.to_ptr)
      return val
    end
  end
end

