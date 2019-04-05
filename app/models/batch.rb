class Batch < ApplicationRecord
    has_many :orders

    scope :search, -> (ref){where(ref: ref) if ref.present?}

    # -----------------------------------------------------------------

    def create(channel ||= "default")
        #@orders = Order.active.purchaseChnl(:channel)
        @orders = Order.purchaseChnl(:channel)
        self.purchase_channel = channel
        self.orders << @orders
        self.ref = "BR-"+Batch.maximum(:id)+1
        self.save? self : nil
    end

end
