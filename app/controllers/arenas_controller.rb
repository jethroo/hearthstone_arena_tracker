class ArenasController < ApplicationController
  def new
    render locals: { arena: Arena.new }
  end
end
