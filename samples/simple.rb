Gtk::init

  w = Gtk::Window.new Gtk::WindowType::TOPLEVEL
  w.add b = Gtk::Button.new_from_stock(Gtk::STOCK_QUIT)
  
  b.signal_connect "clicked" do |widget, data |
    Gtk::main_quit
  end
  
  w.show_all()
  
Gtk::main
