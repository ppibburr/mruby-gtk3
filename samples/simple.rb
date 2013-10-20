# As mruby-girffi advances
# Gtk::init()
# Gtk::init(["array","of","args])
# will be supported
Gtk::init 0,nil

# As mruby-girffi progresses, enums will be supported by name in form of Symbol
# ie, Gtk::Window.new(:toplevel)
w = Gtk::Window.new 0
w.add b = Gtk::Button.new_with_label("Quit")

b.signal_connect "clicked" do
  Gtk::main_quit
end

w.show_all

Gtk::main
