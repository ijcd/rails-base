module Devise
  module Registrations
    class New < SitePrism::Page
      include FactoryGirl::Syntax::Methods
      include Formulaic::Dsl

      set_url '/users/sign_up'

      element :sign_up_button, 'input[value="Sign up"]'

      def register(user)
        fill_form(
          :user,
          full_name: user.full_name,
          'Enter your email address' => user.email,
          password: user.password,
          password_confirmation: user.password_confirmation
        )

        sign_up_button.click
      end
    end
  end
end
