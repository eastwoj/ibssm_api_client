require 'spec_helper'

class User < SuperModel::Base
  include ActiveModel::Validations::Callbacks
  extend IbssmApiClient::ModelAdditions
end