class WarehouseRecord < ActiveRecord::Base
  self.abstract_class = true
  # for live test, use establish_connection :"warehouse_development"
  # establish_connection :"warehouse_#{Rails.env}"
  establish_connection :"warehouse_development"
  # for local test, use establish_connection :"warehouse_#{Rails.env}"
end
