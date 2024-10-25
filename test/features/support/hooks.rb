# Tira screenshot da pagina
After do |scenario|
    scenario_name = scenario.name.gsub(/[^\w\-]/, ' ')
  
    if scenario.failed?
      # Se meu senario falhar tira um print e salva no caminho que defino em helper.rb
      tira_foto(scenario_name.downcase!, 'falhou')
    else
      # Se meu senario falhar tira um print e salva no caminho que defino em helper.rb
      tira_foto(scenario_name.downcase!, 'passou')
    end
  end
  
  def tira_foto(file_name, resultado)
    data = Time.now.strftime('%F').to_s
    h_m_s = Time.now.strftime('%H%M%S%p').to_s
    temp_shot = page.save_screenshot("results/evidencias/#{data}/temp_screen#{h_m_s}.png")
    shot = Base64.encode64(File.open(temp_shot).read)
    attach(temp_shot, 'image/png')
  end
  
  def screenshot()
    sleep(1)
    data = Time.now.strftime('%F').to_s
    caminho = "results/evidencias/#{data}"
    foto = "#{caminho}/#{ENV['BROWSER']}_.png"
    page.save_screenshot(foto)
    attach(foto, 'image/png')
  end
  
  Before do
    Faker::Config.locale = 'pt-BR'
    $first_name_faker = Faker::Name.first_name
    $last_name_faker = Faker::Name.last_name
    $usr_name = Faker::Internet.username(specifier: 5..10)
    $password = Faker::Internet.password(min_length: 10, max_length: 20, mix_case: true)
    $data = Time.now.strftime('%d%m%Y').to_s
    $data_two = Time.now.strftime('%m/%d/%Y').to_s
    $h_m_s = Time.now.strftime('%H%M%S%p').to_s
  end