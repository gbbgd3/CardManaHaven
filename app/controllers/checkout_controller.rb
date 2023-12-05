class CheckoutController < ApplicationController
    def create_checkout_session
        line_items = construct_line_items(session[:cart])
        user_tax = current_user.province

        tax_rate = Stripe::TaxRate.create(
            display_name: "Sales Tax - #{user_tax.tax_type}",
            inclusive: false,
            percentage: user_tax.total_tax_rate,
        )

        @session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            line_items: line_items.map { |item| item.merge(tax_rates: [tax_rate.id]) },
            mode: 'payment',
            success_url: cart_show_url,
            cancel_url: cancel_checkout_index_url,
        )

        redirect_to @session.url, status: :see_other, data: { turbo: false }, allow_other_host: true
    end

    def success
        puts "SUCCESS"
    end

    def cancel
      puts 'Payment canceled.'
      flash[:notice] = 'Payment canceled.'
      redirect_to cart_show_path
    end

    def construct_line_items(cart)
        cart.map do |item|
          product = Product.find(item["id"])
          {
            price_data: {
                currency: 'cad',
                product_data: {
                name: product.product_name,
                description: product.product_detail,
                },
                unit_amount: (product.sale_price_cents < product.price_cents) ? product.sale_price_cents : product.price_cents,
            },
            quantity: item["quantity"]
          }
        end
    end
end