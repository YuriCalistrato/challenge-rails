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
    belongs_to :batch, optional: true
    before_validation :preSave

    # -----------------------------------------------------------------

    # Status Scope
    # Status: Ready, Production, Closing, Sent
    scope :active,      -> { where.not(status: "sent") }
    scope :ready,       -> {where(status: "ready")}
    scope :production,  -> {where(status: "production")}
    scope :closing,     -> {where(status: "closing")}
    scope :sent,        -> {where(status: "sent")}
    # --
    # Conditional Scopes
    scope :purchaseChnl,-> (chnl){where(purchase_channel:chnl)  if chnl.present? }
    scope :deliverySrvc,-> (srvc){where(delivery_srvc:srvc)     if srvc.present? }
    scope :line,        -> (line){where(line_items:line)        if line.present? }
    scope :refSearch,   -> (ref){ where(ref: ref)               if ref.present?  }
    scope :clientSearch,-> (name){ where(client_name: name)     if name.present? }
    # Tool Scope
    scope :total,       -> {sum(:value)}

    # Validate's Presence of everything -------------------------------
    EXCLUDED = ["id", "batch_id", "created_at", "updated_at"]
    VALID = Order.attribute_names.reject{|attr| EXCLUDED.include?(attr)}

    validate :check
    validates_presence_of VALID

    # -----------------------------------------------------------------

    # Custom Validation with Custom Messages
    def check
        if self.id.present?
            errors.add(:check, "Shouldn't have id on creation.") 
        end
        if self.created_at? || self.updated_at?
            errors.add(:check, "Shouldn't have invalid fields on creation.")
        end
    end

    # First State assignment if not assigned
    def preSave
        self.status ||= "ready"
        self.ref ||= "REF"<<(Order.maximum(:id).to_i+1000).to_s # Logistic Measures Only
    end

    # State flow advance
    def nextState
        case
        when self.status == "ready"
            self.update_attribute(:status, "production")
        when self.status == "production"
            self.update_attribute(:status, "closing")
        when self.status == "closing"
            self.update_attribute(:status, "sent")
        end
    end

end
