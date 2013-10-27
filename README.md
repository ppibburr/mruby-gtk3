mruby-gtk3
==========
Gtk bindings to [mruby](https://github.com/mruby/mruby). uses [mruby-girffi](https://github.com/ppibburr/mruby-girffi)

Synopsis
===
A small convenience library that makes working with Gtk easier

Requirements
===
* [mruby-girffi](https://github.com/ppibburr/mruby-girffi) (MRBGEM)
* the requirements for mruby-girffi
* libgtk3
* GIRepository typelib information for Gtk3

Example
===
```ruby
Gtk::init()

w = Gtk::Window.new(:toplevel)
w.add b=Gtk::Button.new_from_stock(Gtk::STOCK_QUIT)

b.signal_connect("clicked") do |widget, data|
  Gtk::main_quit
end

Gtk::main()
```

USING Gtk version 3.x from CRuby (1.9.x)
===
```bash
mkdir ffi_libs
cd ffi_libs
git clone https://github.com/ppibburr/mruby-gobject-introspection.git
git clone https://github.com/ppibburr/mruby-girffi.git
git clone https://github.com/ppibburr/mruby-gtk3.git

cd ..

# ensure ffi gem is installed
# gem i ffi

ruby -rffi -rffi_libs/mruby-gobject-introspection/mrblib/gir.rb -rffi_libs/mruby-girffi/mrblib/mrb_girffi.rb -rffi_libs/mruby-gtk3/mrblib/gtk3.rb path/to/file.rb
```
