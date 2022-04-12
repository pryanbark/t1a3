require 'json'

def data_json
  file = File.read('./data.json')
  return JSON.parse(file)
end

def print_author_books(json_data)
  json_data.each do |auth, books|
    print "AUTHOR: #{auth} \n"
    print_books(books)
  end
end

def print_books(books)
  books.each do |book|
    print "Book: #{book}\n"
  end
  print "\n"
end

def write_to_json(updated_data)
  File.write('./data.json', JSON.dump(updated_data))
end

def add_a_book
  print "\nENTER AUTHOR NAME:\n"
  author = gets.chomp
  print "\nENTER BOOK NAME:\n"
  book_name = gets.chomp
  data = data_json
  if data[author]
    data[author].push(book_name)
  else
    data[author] = [book_name]
  end
  print data
  write_to_json(data)
  print "ADDED " + book_name + " SUCCESSFULLY"
end

def remove_a_book
  print "\nENTER AUTHOR NAME:\n"
  author = gets.chomp
  print "\nENTER BOOK NAME:\n"
  book_name = gets.chomp
  data = data_json
  if data[author] && data[author].include?(book_name)
    data[author].delete(book_name)
    if data[author].length == 0
      data.delete(author)
    end
    print "\nREMOVED " + book_name + " SUCCESSFULLY\n"
  else
    print "\nInvalid author or book name.\n"
  end
  write_to_json(data)
end

def search_a_book
  print "\nENTER AUTHOR NAME:\n"
  author = gets.chomp
  print "\nENTER BOOK NAME:\n"
  book_name = gets.chomp
  data = data_json
  if data[author] && data[author].include?(book_name)
    print "\nGiven book '" + book_name + "' exists for the author '" + author + "' \n"
  else
    print "\nInvalid author or book name\n"
  end
  print "!!!!!!!!!!!!!"
end

def process_input(inp)
  case inp
  when 1
    print_author_books(data_json())
  when 2
    add_a_book
  when 3
    remove_a_book
  when 4
    search_a_book
  end
end

def call_for_action
  print "\n Hi there! Welcome to your books wishlist\n"
  print "\nChoose your action"
  print "\n------------------------------------------------"
  print "\n1. Show all books in wishlist"
  print "\n2. Add a book"
  print "\n3. Delete a book"
  print "\n4. Search a book by author and title"
  print "\n5. Exit \n\n\n"
  print "\nPLEASE ENTER NUMBERS 1-5: \n"
  inp = gets.chomp.to_i

  if inp>0 && inp<6
    if inp == 5
      print "\n----THANK YOU"
      return
    else
      process_input(inp)
      call_for_action
    end
  end
end