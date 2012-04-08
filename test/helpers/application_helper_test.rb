require "minitest_helper"

describe ApplicationHelper do
  it 'has flash_class defined' do
    respond_to?(:flash_class).must_equal true
  end

  describe :flash_class do
    it 'changes notice to info' do
      flash_class(:notice).must_equal 'alert alert-info'
    end

    it 'keeps success as success' do
      flash_class(:success).must_equal 'alert alert-success'
    end

    it 'keeps error as error' do
      flash_class(:error).must_equal 'alert alert-error'
    end

    it 'changes alert to error' do
      flash_class(:alert).must_equal 'alert alert-error'
    end

    it 'falls back to error' do
      flash_class(:notreal).must_equal 'alert alert-error'
    end
  end
end
