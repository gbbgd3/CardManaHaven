ActiveAdmin.register Province do
  permit_params :name, :tax_type, :pst, :gst, :hst, :total_tax_rate
end
