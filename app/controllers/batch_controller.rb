class BatchController < ApplicationController
  def index
    @batches = Batch.all
  end
end
