require 'spec_helper'
require 'byebug'
require 'faker'

describe Shurpa do

  # Configure Shurpa for Testing
  Shurpa.api_base = "https://staging.shurpa.com"
  Shurpa.api_version = "api/v1"
  Shurpa.api_key = "***"

  it 'has a version number' do
    expect(Shurpa::VERSION).not_to be nil
  end

  it 'loads the Shurpa API Account' do
    account = Shurpa::Account.load
    is_valid = account[:name].is_a? String
    expect(is_valid).to eq(true)
  end

  it 'creates a valid delivery' do
    delivery = Shurpa::Delivery.create({
      first_name: Faker::Name.first_name,
      last_name:  Faker::Name.last_name,
      email:  Faker::Internet.email,
      phone:  Faker::PhoneNumber.phone_number,
      street: Faker::Address.street_name,
      unit:   Faker::Address.building_number,
      city:   Faker::Address.city,
      state:  Faker::Address.state_abbr,
      zip:    60605, # only accepts chicago zips
      notes:  SecureRandom.uuid
    })
    is_valid = delivery[:error].nil? && !delivery[:id].nil?
    expect(is_valid).to eq(true)
  end

  it 'does not create invalid delivery' do
    delivery = Shurpa::Delivery.create({
      # empty request body
    })
    is_invalid = !delivery[:error].nil?
    expect(is_invalid).to eq(true)
  end

  it 'finds a valid delivery' do
    delivery = Shurpa::Delivery.create({
      first_name: Faker::Name.first_name,
      last_name:  Faker::Name.last_name,
      email:  Faker::Internet.email,
      phone:  Faker::PhoneNumber.phone_number,
      street: Faker::Address.street_name,
      unit:   Faker::Address.building_number,
      city:   Faker::Address.city,
      state:  Faker::Address.state_abbr,
      zip:    60605, # only accepts chicago zips
      notes:  SecureRandom.uuid
    })
    unless delivery[:id].nil?
      lookup = Shurpa::Delivery.find(delivery[:id])
      unless lookup[:id].nil?
        is_valid = delivery[:id] === lookup[:id]
        expect(is_valid).to eq(true)
      else
        return false
      end
    else
      return false
    end
  end

end
