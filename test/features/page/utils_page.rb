#Classe criada para inclusao de dados frequentes
class Utils < SitePrism::Page
    set_url ' '
    def faz_login
        find(ELL['usr_name']).set 'standard_user'
        find(ELL['pswd']).set 'secret_sauce'
        find(ELL['login_bt']).click

    end

    def faz_compra
        find(ELL['item_backpack']).click
        find(ELL['carrinho']).click
        find(ELL['checkout']).click
        find(ELL['insert_name']).set 'abcdee'
        find(ELL['insert_lname']).set 'qweffsas'
        find(ELL['insert_zip']).set '1234564'
        find(ELL['continue_btn']).click
        find(ELL['finish_btn']).click
end

end
