#language: pt


Funcionalidade: Login de Admin

@login
  Cenário: Realizar login com credenciais válidas
    Dado que estou na página de login
    Quando realizo o login com credenciais válidas
    Então devo estar logado no sistema