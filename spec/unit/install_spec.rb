require 'unit/spec_helper'

describe 'sprout-mysql::install' do
  let(:runner) { ChefSpec::SoloRunner.new }

  before do
    stub_command(/mysql /)
    stub_command('which git')
  end

  it 'installs mysql' do
    runner.converge(described_recipe)
    expect(runner).to install_package('mysql')
  end

  it 'uses a default root password of `password`' do
    runner.converge(described_recipe)
    expect(runner).to run_execute('mysqladmin -uroot password password')
  end

  it 'uses the specified root password' do
    runner.node.set['sprout']['mysql']['root_password'] = 'custompassword'
    runner.converge(described_recipe)
    expect(runner).to run_execute('mysqladmin -uroot password custompassword')
  end
end
