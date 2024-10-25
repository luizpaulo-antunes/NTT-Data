# Chamando todas as dependencias q
require 'capybara'
require 'capybara/cucumber'
require 'capybara/dsl'
require 'capybara/rspec/matchers'
require 'faker'
require 'rspec'
require 'selenium-webdriver'
require 'site_prism'
require 'report_builder'
require 'httparty'
require 'json'
require 'pry'

require_relative 'page_helper.rb' ##Arquivo que inicia todas as minhas classes

World Capybara::DSL
World Capybara::RSpecMatchers

World Page

BROWSER = ENV['BROWSER'] ##tagueamento para escolha de Browsaer
AMB = ENV['AMB']


BASE_URL = YAML.load_file(File.dirname(__FILE__) + "/ambientes/ambientes.yml")[AMB] ## Caminho de arquivo com definiçoes de ambiente
LOADS = YAML.load_file(File.dirname(__FILE__) + "/loads/loads.yml")
ELL = YAML.load_file(File.dirname(__FILE__) + "/loads/elements.yml")
$RETURNS = YAML.load_file(File.dirname(__FILE__) + "/loads/returns.yml")

case AMB
when AMB.empty?
  raise "Constante AMB está vazia.\nPor favor, especificar Ambiente: (prod, ti, qa)."
  RSpec.configure do |config|
    config.filter_run_excluding type: :feature
  end
end
## executa navegador de acordo com o navegador escolhido em cucumber.yml
# :selenium_headless, :selenium_chrome, :selenium_chrome_headless
case BROWSER
when "chrome"
  Capybara.register_driver :selenium_chrome do |app|
    Capybara::Selenium::Driver.load_selenium
    browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      opts.args << '--disable-site-isolation-trials'
      opts.args << '--start-maximized'
      opts.args << '--incognito'
    end
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
  end
  @driver = :selenium_chrome
when "chrome_headless"
  Capybara.register_driver :selenium_chrome_headless do |app|
    Capybara::Selenium::Driver.load_selenium
    browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      opts.args << '--headless'
      opts.args << '--disable-gpu' if Gem.win_platform?
      opts.args << '--no-sandbox'
      opts.args << '--incognito'
      opts.args << '--window-size=1200x680'
      opts.args << '--disable-site-isolation-trials'
    end
    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      options: browser_options
    )
  end
  @driver = :selenium_chrome_headless
when "two_chrome_headless"
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(
      app,
      browser: :chrome,
      desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
        'goog:chromeOptions' => {
          'args' => [
            '--window-size=1871x949',
            '--headless',
            '--disable-gpu',
            '--no-sandbox'
          ]
        }
      )
    )
  end
  @driver = :selenium
when BROWSER.blank?
  raise "Constante BROWSER está vazia.\nPor favor, especificar BROWSER: [chrome, chrome_headless]."
end

#essa variável ambiente recebe uma configuração do ENV. voce pode apagar os IFs ali e deixar o nome chumbado
ReportBuilder.configure do |config|
  config.json_path = "results/report.json" #pasta onde salva o json
  config.report_path = "results/report" #pasta onde salva o html
  config.report_types = [:html] #tipo de report a exportar
  config.report_title = "Report de testes WEB_RD" #nome do report
  config.color = "purple" #cor do report
  config.include_images = true #se coloca imagens ou não
  config.additional_info = {ambiente: ENV['AMB'], url: BASE_URL['base_url']} 
end

at_exit do 
  ReportBuilder.build_report
end

Capybara.configure do |config|
  config.default_driver = @driver ## Variavel para definição de Browser
  config.app_host = BASE_URL['base_url']
  config.default_max_wait_time = 15 ## Time global de espera
end