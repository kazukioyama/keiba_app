# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


LargeLineage.create!(
  [
    {
      name: 'ナスルーラ系'
    },
    {
      name: 'ネイティヴダンサー系'
    },
    {
      name: 'ミスタープロステクター系'
    },
    {
      name: 'ターントゥ系'
    },
    {
      name: 'サンデーサイレンス系'
    },
    {
      name: 'ノーザンダンサー系'
    },
    {
      name: 'ハンプトン系'
    },
    {
      name: 'セントサイモン系'
    },
    {
      name: 'マイナー系'
    },
    {
      name: 'ヘロド系'
    },
    {
      name: 'マッチェム系'
    },
  ]
)

Stalion.create!(
  [
    {
      name: '',
      medium_lineage_id: 
    }
  ]
)