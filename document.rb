require "fileutils"

if ARGV.length > 0
  puts "Writes YARD documentation to ./doc"
  exit(1)
end

unless `mruby -e "puts Gtk::MAJOR_VERSION"`.split("\n").last.to_i == 3
  puts "ABORT: Gtk version != 3.x"
  exit(127)
end

`rm -rf ./tmp`
`mkdir ./tmp`

File.open("./tmp/runner.rb","w") do |f|
  f.puts DATA.read
end
runner = File.expand_path("./tmp/runner.rb")
od = File.expand_path(Dir.getwd)
`rm -rf doc`
Dir.chdir("../mruby-girffi-docgen-html/")
system "ruby bin/docgen --lib=Gtk --runner=#{runner}"
`cp -rf ./tmp/doc #{od}/`
`rm -rf ./tmp`

Dir.chdir od
`rm -rf ./tmp`

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
ns = dg.document
g = DocGen::Generator::HTML.new(ns)
g.generate
