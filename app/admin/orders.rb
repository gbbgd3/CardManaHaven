ActiveAdmin.register Order do
  permit_params :user_id, :status_id, :stripe_id, :order_complete_date, :subtotal, :total, :tax_rate, :tax_display
  index do
    selectable_column
    id_column
    column :user
    column :status
    column :stripe_id
    column :order_subtotal
    column :order_total
    column :tax_rate
    column :tax_display
    actions
  end

  form do |f|
    f.inputs "Order Details" do
      f.input :status, as: :select, collection: Status.all.map { |s| [s.name, s.id] }, include_blank: false
    end
    f.actions
  end

  filter :user
  filter :status
  filter :stripe_id
  filter :order_subtotal
  filter :order_total
  filter :tax_rate
  filter :tax_display
end
