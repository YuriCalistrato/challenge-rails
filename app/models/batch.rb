# == Schema Information
#
# Table name: batches
#
#  id               :bigint(8)        not null, primary key
#  ref              :string
#  purchase_channel :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Batch < ApplicationRecord
    has_many :orders
    before_validation :preSave
    after_create :postCreate

    scope :search,          -> (ref){where(ref: ref) if ref.present?}
    scope :purchaseChnl,    -> (cnh){where(purchase_channel: cnh) if cnh.present?}

    # -----------------------------------------------------------------
    EXCLUDED = ["id", "created_at", "updated_at"]
    VALID = Batch.attribute_names.reject{|attr| EXCLUDED.include?(attr)}

    validate :check
    validates_presence_of VALID # Purchase Channel
    # -----------------------------------------------------------------

    def preSave
        self.ref ||= "BR-"<<(Batch.maximum(:id).to_i+1).to_s
    end

    def check
        if self.id.present?
            errors.add(:check, "Shouldn't have id on creation.") 
        end
        if self.created_at? || self.updated_at?
            errors.add(:check, "Shouldn't have invalid fields on creation.")
        end
    end

    def postCreate
        orders = Order.active.purchaseChnl(self.purchase_channel)
        self.orders << orders
        self.save
    end

end
