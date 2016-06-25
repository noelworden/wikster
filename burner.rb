require "stripe"
Stripe.api_key = "sk_test_BQokikJOvBiI2HlWgH4olfQ2"

Stripe::Charge.create(
  :amount => 400,
  :currency => "usd",
  :source => {
    :number => "4242424242424242",
    :exp_month => 6,
    :exp_year => 2017,
    :cvc => "314"
  },
  :description => "Charge for test@example.com"
)