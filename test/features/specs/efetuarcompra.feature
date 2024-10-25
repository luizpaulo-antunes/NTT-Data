
#language: pt


Funcionalidade: Compra

@efetuarcompra

Cenário: compra de jaqueta
    Dado que esto logado
    Quando devo ter um item no carrinho
    Então verifico compra com sucesso
    