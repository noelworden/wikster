class ChargesController < ActionController::Base
  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
      )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 1500,
      description: "#{current_user.email} premium membership fee testing",
      currency: 'usd',
      )

    flash[:notice] = "Thanks for becoming a premium member"
    redirect_to user_path(current_user)

    rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "premium membership fee testing",
      amount: 1500
    }
  end
end