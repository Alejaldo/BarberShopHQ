class CreateBarbers < ActiveRecord::Migration[6.0]
  def change
    create_table :barbers do |t|
      t.text :name

      t.timestamps
    end

    Barber.create :name => 'Donald Trump'
    Barber.create :name => 'Barack Obama'
    Barber.create :name => 'Elon Musk'

  end
end
