require 'rails_helper'

RSpec.describe Todo, type: :model do
  it "is valid with a description" do
    todo = Todo.new(description: "Buy milk")
    expect(todo).to be_valid
  end

  it "is invalid without a description" do
    todo = Todo.new(description: nil)
    todo.valid?
    expect(todo.errors[:description]).to include("can't be blank")
  end
end