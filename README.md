# NTTDATA

# Software e Configuração:
- Neste projeto estou fazendo automação de testes web usando [Ruby](https://www.ruby-lang.org/pt/) como linguagem de programação, [RSpec](https://rspec.info/) ações e validações, [Cucumber](https://cucumber.io/) para interpretação de Scenarios, Steps e construção da estrutura, Estou usando o proprio [GitHub](https://github.com/) repositório dos meus casos de testes.
    - Não estou especificando versões para minhas Gems
    - Minhas declaraçoes de dependencias estão no arquivo Gemfile
    - Tudo o que será executado nesse projeto está sendo declarado no cucumber.yml

# Os testes estão rodando nos ambientes:
    - TI
    - QA
    - PROD

## Options
* `AMB` - Em qual ambiente o teste deve ser executado
    * `ti`
    * `qa` <- default
    * `prod` 

Running Tests (Examples):

    $ bundle exec cucumber -p ci AMB=qa
ou

    $ cucumber AMB=qa
