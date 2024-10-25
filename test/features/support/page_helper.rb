Dir[File.join(File.dirname(__FILE__), '../page/*.rb')].each { |file| require file }

# Depois que pegar os arquivos com (_page.rb) estancio todos as suas variaveis
module Page
  def login
    @login ||= Utils.new

  end
end