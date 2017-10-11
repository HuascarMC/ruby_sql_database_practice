require('pg')

class Bounty
  attr_reader :id

  attr_accessor :name, :bounty_value, :danger, :homeworld
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
            "   # Could use returning "id" and it would return an array with one hash with only the id inside.
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

  def delete()
    db = PG.connect({
      dbname: 'space_cowboys',
      host: 'localhost'
      })
      sql = "DELETE FROM bounties WHERE id = $1"
      values = [@id]
      db.prepare("delete", sql)
      db.exec_prepared("delete", values)
      db.close()
  end

  def update()
    db = PG.connect({
      dbname: 'space_cowboys',
      host: 'localhost'
      })
      sql = "UPDATE bounties SET
      (
      name, bounty_value, danger_level, homeworld
      ) =
      (
      $1, $2, $3, $4
      )
      "
      values = [@name, @bounty_value, @danger_level, @homeworld]
      db.prepare("update", sql)
      db.exec_prepared("update", values)
      db.close()
  end


  def self.find(id)
    db = PG.connect({
      dbname: 'space_cowboys',
      host: 'localhost'
      })
      sql = "SELECT * FROM bounties
      WHERE id = $1"
      values = [id]
      db.prepare("find", sql)
      bounty_in_array = db.exec_prepared("find", values)[0]
      this_bounty = Bounty.new(bounty_in_array)
      db.close()
      return this_bounty
  end

  # def self.find(id)                      This works but it's unnecessary
    # all = Bounty.select()                why would I use ruby to loop
  #   for bounty in all                    through the whole database,
  #     if bounty.id == id                 this is what SQL is for.
  #        return bounty
  #     end
  #   end
  # end
end
