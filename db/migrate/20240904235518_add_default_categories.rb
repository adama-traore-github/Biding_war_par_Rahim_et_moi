class AddDefaultCategories < ActiveRecord::Migration[6.1]
  def up
    Category.create(name: 'Art', description: 'Œuvres d\'art et créations artistiques')
    Category.create(name: 'Beauté', description: 'Produits de beauté et soins personnels')
    Category.create(name: 'Trésors', description: 'Articles de collection et objets rares')
    Category.create(name: 'Games', description: 'Jeux vidéo et jeux de société')
  end

  def down
    Category.delete_all
  end
end
