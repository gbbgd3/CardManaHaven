class CheckoutController < ApplicationController
    def create_checkout_session
        line_items = construct_line_items(session[:cart])
        user_tax = current_user.province

        tax_rate = Stripe::TaxRate.create(
            display_name: "Sales Tax - #{user_tax.tax_type}",
            inclusive: false,
            percentage: user_tax.total_tax_rate,
            jurisdiction: "Canada - #{user_tax.name}"
        )

        @session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            line_items: line_items.map { |item| item.merge(tax_rates: [tax_rate.id]) },
            mode: 'payment',
            metadata: {
                tax_rate_id: tax_rate.id,
                tax_rate_display_name: tax_rate.display_name,
                tax_percentage: tax_rate.percentage,
                jurisdiction: tax_rate.jurisdiction
            },
            success_url: "#{success_checkout_index_url}?session_id={CHECKOUT_SESSION_ID}",
            cancel_url: cancel_checkout_index_url,
        )

        redirect_to @session.url, status: :see_other, data: { turbo: false }, allow_other_host: true
    end

    def success
      session_id = params[:session_id]
      stripe_session = Stripe::Checkout::Session.retrieve(session_id)
      #get amount total and subtotal
      products_info = construct_line_items(session[:cart])
      
      puts products_info.inspect
      tax_information = getTaxInfo(stripe_session["metadata"])
      status = Status.find_or_create_by(name: stripe_session["payment_status"])

      order = Order.create!(
        user: current_user,
        status:,
        stripe_id: session_id,
        subtotal: stripe_session["amount_subtotal"],
        total: stripe_session["amount_total"],
        tax_rate: tax_information[:tax_percentage],
        tax_display: tax_information[:tax_rate_display_name],
      )

      create_order_products(session[:cart], order)
  
      flash[:success] = 'Payment Completed!'
      redirect_to cart_show_path
    end

    def cancel
      puts 'Payment canceled.'
      flash[:notice] = 'Payment canceled.'
      redirect_to cart_show_path
    end

    private

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

    def create_order_products(cart, order)
      cart.each do |item|
        product = Product.find(item["id"].to_i)
        price_cents = (product.sale_price_cents < product.price_cents) ? product.sale_price_cents : product.price_cents
        order_product = OrderProduct.create!(
          order: order,
          product_id: product.id,
          product_name: product.product_name,
          product_price: price_cents,
          product_quantity: item["quantity"].to_i,
          product_subtotal: price_cents * item["quantity"].to_i
        )

        product.stock -= item["quantity"].to_i
        product.save
      end
    end

    def getTaxInfo(metadata)
      tax_rate_display_name = metadata["tax_rate_display_name"]
      tax_percentage = metadata["tax_percentage"]
      tax_jurisdiction = metadata["jurisdiction"]
      {
        tax_rate_display_name:,
        tax_percentage:,
        tax_jurisdiction:,
      }
    end
end