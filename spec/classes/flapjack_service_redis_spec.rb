#!/usr/bin/env rspec
require 'spec_helper'
@prd_processor_archive_events

describe 'flapjack::service::redis', :type => :class do
  context 'input validation' do

#    ['path'].each do |paths|
#      context "when the #{paths} parameter is not an absolute path" do
#        let (:params) {{ paths => 'foo' }}
#        it 'should fail' do
#          expect { subject }.to raise_error(Puppet::Error, /"foo" is not an absolute path/)
#        end
#      end
#    end#absolute path

#    ['array'].each do |arrays|
#      context "when the #{arrays} parameter is not an array" do
#        let (:params) {{ arrays => 'this is a string'}}
#        it 'should fail' do
#           expect { subject }.to raise_error(Puppet::Error, /is not an Array./)
#        end
#      end
#    end#arrays

    ['redis_omnibus'].each do |bools|
      context "when the #{bools} parameter is not an boolean" do
        let (:params) {{bools => "BOGON"}}
        it 'should fail' do
          expect { subject }.to raise_error(Puppet::Error, /"BOGON" is not a boolean.  It looks to be a String/)
        end
      end
    end#bools

#    ['hash'].each do |hashes|
#      context "when the #{hashes} parameter is not an hash" do
#        let (:params) {{ hashes => 'this is a string'}}
#        it 'should fail' do
#           expect { subject }.to raise_error(Puppet::Error, /is not a Hash./)
#        end
#      end
#    end#hashes

#    ['opt_hash'].each do |opt_hashes|
#      context "when the optional param #{opt_hashes} parameter has a value, but not a hash" do
#        let (:params) {{ hashes => 'this is a string'}}
#        it 'should fail' do
#           expect { subject }.to raise_error(Puppet::Error, /is not a Hash./)
#        end
#      end
#    end#opt_hashes

#    ['regex'].each do |regex|
#      context "when #{regex} has an unsupported value" do
#        let (:params) {{regex => 'BOGON'}}
#        it 'should fail' do
#          expect { subject }.to raise_error(Puppet::Error, /"BOGON" does not match/)
#        end
#      end
#     end#regexes

#    ['string'].each do |strings|
#      context "when the #{strings} parameter is not a string" do
#        let (:params) {{strings => false }}
#        it 'should fail' do
#          expect { subject }.to raise_error(Puppet::Error, /false is not a string./)
#        end
#      end
#    end#strings

#    ['opt_strings'].each do |optional_strings|
#      context "when the optional parameter #{optional_strings} has a value, but it is not a string" do
#        let (:params) {{optional_strings => true }}
#        it 'should fail' do
#          expect { subject }.to raise_error(Puppet::Error, /true is not a string./)
#        end
#      end
#    end#opt_strings

  end#input validation
  context "When on a Debian system" do
    let (:facts) {{'osfamily' => 'Debian'}}
    let (:pre_condition){"class{'::flapjack':}"}
    context 'when fed no parameters' do
      it {
        should contain_service('redis-flapjack').with({
          :name=>"redis-flapjack",
          :ensure=>true,
          :enable=>true,
          :hasstatus=>true,
          :hasrestart=>false}
        )
        .that_requires('File[/opt/flapjack/embedded/etc/redis/redis-flapjack.conf]')
        .that_subscribes_to('Package[flapjack]')
        .that_subscribes_to('File[/opt/flapjack/embedded/etc/redis/redis-flapjack.conf]')
      }
    end#no params
    context 'when the redis_omnibus param is false' do
      let (:facts) {{'osfamily' => 'Debian'}}
      let (:pre_condition){"class{'::flapjack': redis_omnibus => false}"}
      it {
        should contain_service('redis-flapjack').with({
          :name=>'redis-flapjack',
          :ensure=>false,
          :enable=>false,
          :hasstatus=>true,
          :hasrestart=>false}
        )
        .that_subscribes_to('Package[flapjack]')
      }
    end
  end
end
