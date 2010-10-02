Factory.define :book_one, :class => Book do |b|
  include ActionDispatch::TestProcess
  b.title 'Agile Web Development with Rails (3rd edition)'
  b.author 'Sam Ruby'
  b.isbn '1934356166'
  b.isbn13 '9781934356166'
  b.image { fixture_file_upload("files/missing.png", 'image/png') }
end

Factory.define :book_two, :class => Book do |b|
  include ActionDispatch::TestProcess
  b.title 'The Ruby Way'
  b.author 'Hal Fulton'
  b.isbn '0672328844'
  b.isbn13 '9780672328848'
  b.image { fixture_file_upload("files/missing.png", 'image/png') }
end