class Order < ApplicationRecord
    has_and_belongs_to_many :batches

    # Status Scope
    # Status: Ready, Production, Closing, Sent, Received
    scope :active, -> { where.not(status: "received") }

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

    # Validate's Presence of everything
    EXCLUDED = ["id", "created_at", "updated_at"]
    VALID = Order.attribute_names.reject{|attr| EXCLUDED.include?(attr)}

    validates_presence_of VALID

    def send
        self.update_attribute(status: "sent")
    end
end
