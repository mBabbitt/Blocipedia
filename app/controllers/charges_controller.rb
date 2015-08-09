class ChargesController < ApplicationController

  def new
    @amount = 15_00
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: @amount
    }
  end

  def create
    @amount = 15_00

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.update_attribute(:role, 'premium')

    flash[:success] = "Your payment has been receieved. Thank you!"
    redirect_to wikis_path 

  rescue Stripe::CardError => e
    current_user.update_attribute(:role, 'standard')
    flash[:error] = e.message
    redirect_to new_charge_path
  end

def downgrade
    customer = Stripe::Customer.retrieve(current_user.customer_id)

    charges_id = customer.charges.data.first.id
    current_user.update_attributes(role: 'standard')
    current_user.make_wikis_public
    redirect_to edit_user_registration_path
  end
end
