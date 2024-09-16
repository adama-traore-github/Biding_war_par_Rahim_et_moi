# Créer des catégories
art_category = Category.find_or_create_by!(name: 'Art') do |category|
  category.description = 'Catégorie dédiée aux œuvres d\'art.'
end

beauty_category = Category.find_or_create_by!(name: 'Beauté') do |category|
  category.description = 'Catégorie dédiée aux produits de beauté.'
end

# Créer des utilisateurs
buyer = User.find_or_create_by!(
  email: 'buyer@example.com'
) do |user|
  user.name = 'Jane Buyer'
  user.password = 'password123'
  user.role = 'buyer'
  user.confirmed_at = Time.now # Marquer comme confirmé
end

seller = User.find_or_create_by!(
  email: 'seller@example.com'
) do |user|
  user.name = 'John Seller'
  user.password = 'password123'
  user.role = 'seller'
  user.confirmed_at = Time.now # Marquer comme confirmé
end

both_user = User.find_or_create_by!(
  email: 'both@example.com'
) do |user|
  user.name = 'Jane Both'
  user.password = 'password123'
  user.role = 'both'
  user.confirmed_at = Time.now # Marquer comme confirmé
end

# Chemins vers les images
art_image_path1 = Rails.root.join('app', 'assets', 'images', 'Sans1 titre.jpeg')
art_image_path2 = Rails.root.join('app', 'assets', 'images', '1Sans titre.jpeg')
beauty_image_path = Rails.root.join('app', 'assets', 'images', 'images1.jpeg')

# Créer des produits

# Produit Aquarelle - Enchères de 3 semaines
Product.find_or_create_by!(name: 'Aquarelle') do |product|
  product.category = art_category
  product.initial_price = 50.00
  product.auction_start_date = Time.now + 1.day
  product.auction_end_date = Time.now + 3.weeks
  product.seller = seller
  product.description = 'Une magnifique aquarelle de haute qualité.'
  product.image.attach(io: File.open(art_image_path1), filename: 'Sans1_titre.jpeg')
end

# Produit Pikasso - Enchères d'1 an
Product.find_or_create_by!(name: 'Pikasso') do |product|
  product.category = art_category
  product.initial_price = 75.00
  product.auction_start_date = Time.now + 1.day
  product.auction_end_date = Time.now + 1.year
  product.seller = both_user
  product.description = 'Une œuvre d’art inspirée de Picasso.'
  product.image.attach(io: File.open(art_image_path2), filename: '1Sans_titre.jpeg')
end

# Nouveau produit pour le vendeur
Product.find_or_create_by!(name: 'Produit Beauté') do |product|
  product.category = beauty_category
  product.initial_price = 100.00
  product.auction_start_date = Time.now + 1.day
  product.auction_end_date = Time.now + 7.days
  product.seller = seller
  product.description = 'Un produit de beauté exceptionnel pour améliorer votre apparence.'
  product.image.attach(io: File.open(beauty_image_path), filename: 'beauty_product_image.jpeg')
end
