require 'rails_helper'

describe Order, :type => :model do
    it "[Inits] - Instance test" do
        order = Order.new
        expect(order).not_to be_nil
    end

    it "[Valid] - Only valid with valid fields"
    it "[Scope] - Active can't be on status Sent"
end