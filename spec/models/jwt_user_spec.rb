require 'rails_helper'

describe JwtUser do
  let(:jwt_payload) do
    {
      uid: 'db398baf-80c1-4d70-a2ce-87f5a097d636',
      jti: '96b35b36-38f3-436a-99a7-20dc6a88ab4d',
      roles: ['rol1', 'rol2']
    }
  end

  describe '#initialize' do
    it 'requires a uid keyword' do
      jwt_payload.delete(:uid)

      expect { described_class.new(jwt_payload) }
        .to raise_error ArgumentError
    end

    it 'requires a roles keyword' do
      jwt_payload.delete(:roles)

      expect { described_class.new(jwt_payload) }
        .to raise_error ArgumentError
    end

    it 'requires a jti keyword' do
      jwt_payload.delete(:jti)

      expect { described_class.new(jwt_payload) }
          .to raise_error ArgumentError
    end
  end

  describe '#has_access?' do
    let(:jwt_user) { described_class.new(jwt_payload) }

    it 'returns true when given role is in the list' do
      expect(jwt_user.has_access?('rol1')).to eq true
    end

    it 'returns false when given role is not in the list' do
      expect(jwt_user.has_access?('rol4')).to eq false
    end
  end

  describe 'respond to ?' do
    let(:jwt_user) { described_class.new(jwt_payload) }

    it 'responds to uid' do
      expect(jwt_user.respond_to?(:uid)).to be_truthy
    end

    it 'responds to jti' do
      expect(jwt_user.respond_to?(:jti)).to be_truthy
    end
  end
end
