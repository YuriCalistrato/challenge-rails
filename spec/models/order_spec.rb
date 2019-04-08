# == Schema Information
#
# Table name: orders
#
#  id               :bigint(8)        not null, primary key
#  ref              :string
#  purchase_channel :string
#  client_name      :string
#  address          :string
#  delivery_srvc    :string
#  value            :float
#  line_items       :string
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  batch_id         :bigint(8)
#

require 'rails_helper'

describe Order, :type => :model do
    it "[Inits] - Instance test" do
        order = Order.new
        expect(order).not_to be_nil
    end

    it "[Valid] - Only valid with valid fields"
    it "[Scope] - Active can't be on status Sent"
end
