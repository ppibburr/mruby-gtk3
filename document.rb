require "fileutils"

if ARGV.length > 0
  puts "Writes YARD documentation to ./doc"
  exit(1)
end

FileUtils.mkdir_p d="./tmp/dummy_source"

Dir.chdir d

File.open "document.rb", "w" do |f|
  f.puts DATA.read
end

system "mruby document.rb"
system "yard doc gtk*.rb"

# FileUtils.rm_f "../../doc"
`rm -rf ../../doc`
FileUtils.mv "doc", "../../"

Dir.chdir "../../"
`rm -rf tmp`

__END__
DocGen.overide Gtk, :init do
  param :argv => [[String], "Argument vector", true]
  returns "void"
end

DocGen.overide Gtk::ListStore, :set do
  symbol :gtk_list_store_set
  scope :instance
  
  param :iter => ["Gtk::TreeIter", "The iter"]
  param :col  => [Integer, "The column"]
  param :val  => ["::Object", "The Value"]
  
  returns "void"
end

DocGen.overide Gtk::TreeModel, :get do
  symbol :gtk_tree_model_get
  scope :instance
  
  param :iter => ["Gtk::TreeIter", "The iter"]
  param :col  => [Integer, "The column"]
  
  returns "::Object", "the value"
end

DocGen.overide Gtk::TreeModel, :get_value do
  symbol :gtk_tree_model_get_value
  scope :instance
  
  param :iter => ["Gtk::TreeIter", "The iter"]
  param :col  => [Integer, "The column"]
  
  returns "GObject::Value", "that wraps the value"
end

dg = DocGen.new(Gtk)
ns = dg.document()

YARDGenerator.generate(ns)
