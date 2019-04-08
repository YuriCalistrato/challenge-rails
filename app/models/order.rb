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

class Order < ApplicationRecord
    belongs_to :batch

    # -----------------------------------------------------------------

    # Status Scope
    # Status: Ready, Production, Closing, Sent
    scope :active, -> { where.not(status: "sent") }

    scope :ready,       -> {where(status: "ready")}
    scope :production,  -> {where(status: "production")}
    scope :closing,     -> {where(status: "closing")}
    scope :sent,        -> {where(status: "sent")}

    scope :purchaseChnl,-> (chnl){where(purchase_channel:chnl)  if chnl.present? }
    scope :deliverySrvc,-> (srvc){where(devilery_srvc:srvc)     if srvc.present? }
    scope :line,        -> (line){ where(line_items:line)       if line.present? }

    scope :refSearch,   -> (ref){ where(ref: ref)               if ref.present?  }
    scope :clientSearch,-> (name){ where(client_name: name)     if name.present? }

    scope :total,       -> {sum(:value)}

    # Validate's Presence of everything -------------------------------
    EXCLUDED = ["id", "created_at", "updated_at"]
    VALID = Order.attribute_names.reject{|attr| EXCLUDED.include?(attr)}

    validates_presence_of VALID

    # -----------------------------------------------------------------

    def create
    end

    def nextState
        case
        when self.status == "ready"
            self.update_attribute(status: "production")
        when self.status == "production"
            self.update_attribute(status: "closing")
        when self.status == "closing"
            self.update_attribute(status: "sent")
        end
    end

end
