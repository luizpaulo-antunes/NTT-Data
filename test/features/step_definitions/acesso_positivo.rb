  
  Dado('que estou na página de login') do
    login.load

  end
  Quando('realizo o login com credenciais válidas') do
    login.faz_login
    

  end
  
  Então('devo estar logado no sistema') do
   expect(page).to have_content("Swag Labs")
   screenshot
  end

