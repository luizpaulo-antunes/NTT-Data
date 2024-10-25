

Dado('que esto logado') do
    login.load
    login.faz_login   
  end
  
Quando('devo ter um item no carrinho') do
    login.faz_compra

  end
Então('verifico compra com sucesso') do
    expect(page).to have_content("Thank you for your order!")
    screenshot
  end