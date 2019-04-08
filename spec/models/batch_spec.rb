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

require 'rails_helper'

describe Batch, :type => :model do
    it "[Inits] - Instance test" do
        batch = Batch.new
        expect(batch).not_to be_nil
    end

    it "[Valid] - Only valid with valid fields"
    it "[Scope] - Active can't be on status Sent"
end
