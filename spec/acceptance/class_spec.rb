require 'spec_helper_acceptance'

describe 'gemirro class' do
  context 'default parameters' do
    it 'should work idempotently with no errors' do
      pp = <<-EOS
      class { 'ruby': }
      ->
      class { 'ruby::dev': }
      ->
      class { 'gemirro': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe package('gemirro') do
      it { is_expected.to be_installed.by('gem') }
    end

  end
end
