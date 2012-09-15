module IbssmApiClient
  class IbssmApiRailtie < ::Rails::Railtie
    initializer 'iBSSM client config' do
      IbssmApiClient.logger = Rails.logger
    end
  end
end