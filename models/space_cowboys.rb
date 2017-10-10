require('pg')

class Bounty
  attr_accessor :name, :bounty_value, :danger, :homeworld

  attr_reader :id
  def initialize(options)
    @id = options['id'] if options['id']
    @name = options['name']
    @bounty_value = options['bounty_value'].to_i
    @danger_level = options['danger_level']
    @homeworld = options['homeworld']
  end

  def insert()
    db = PG.connect({
      dbname: 'space_cowboys',
      host: 'localhost'
      })
      sql = "
            INSERT INTO bounties
            (
              name, bounty_value, danger_level, homeworld
            )
            VALUES
            (
              $1, $2, $3, $4
            )
            RETURNING *
            "
      values = [@name, @bounty_value, @danger_level, @homeworld]
      db.prepare("insert", sql)
      @id = db.exec_prepared("insert", values)[0]['id'].to_i()
      db.close()
  end

  def self.select()
  db = PG.connect({
    dbname: 'space_cowboys',
    host: 'localhost'
    })
    sql = "SELECT * FROM bounties"
    values = []
    db.prepare("select", sql)
    bounties_array = db.exec_prepared("select", values)
    db.close()
    bounties_compiled = bounties_array.map { |bounty| Bounty.new(bounty) }
    return bounties_compiled
  end

end
