Gtk::init()

class RubyApp < Gtk::Window
  @data = superclass.data

  def initialize *o
    super *o

    set_title "Undo redo"
    
    signal_connect "destroy" do 
        Gtk.main_quit 
    end
    
    @count = 2
    
    init_ui

    set_default_size 250, 200

    set_position Gtk::WindowPosition::CENTER
    
    show_all
  end

  def init_ui
    toolbar = Gtk::Toolbar.new
    toolbar.set_style Gtk::ToolbarStyle::ICONS

    @undo = Gtk::ToolButton.new_from_stock Gtk::STOCK_UNDO
    @redo = Gtk::ToolButton.new_from_stock Gtk::STOCK_REDO
    
    sep = Gtk::SeparatorToolItem.new
    
    quit = Gtk::ToolButton.new_from_stock Gtk::STOCK_QUIT

    toolbar.insert @undo, 0
    toolbar.insert @redo, 1
    toolbar.insert sep,   2
    toolbar.insert quit,  3
    
    @undo.signal_connect "clicked" do
      on_undo
    end
     
    @redo.signal_connect "clicked" do
      on_redo
    end
    
    quit.signal_connect "clicked" do
      Gtk.main_quit
    end

    vbox = Gtk::VBox.new false, 2
    vbox.pack_start toolbar, false, false, 0
    
    vbox.pack_start b=Gtk::Button.new_from_stock(Gtk::STOCK_QUIT), true,false, 2

    b.signal_connect "clicked" do
      Gtk::main_quit
    end

    self.add vbox
  end

  def on_undo
    @count = @count - 1

    if @count <= 0
      @undo.set_sensitive false
      @redo.set_sensitive true
    end
  end


  def on_redo
    @count = @count + 1

    if @count >= 5
      @redo.set_sensitive false
      @undo.set_sensitive true
    end
  end

  def self.new
    ins = super Gtk::WindowType::TOPLEVEL
 
    ins.send :initialize
    
    return ins
  end
end

w = RubyApp.new

Gtk::main

