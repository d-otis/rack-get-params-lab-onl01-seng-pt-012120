class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)


    elsif req.path.match(/add/)
      new_item = req.params['item']
      # resp.write "#{@@items.include?(new_item.capitalize)}"
      # if it's in the items list then add it to the cart
      if @@items.include?(new_item.capitalize)
        @@cart << new_item.capitalize
        resp.write "#{item} was added to cart!"
      else
        resp.write "#{item} is not included in our inventory"
      end

    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each {|item| resp.write "#{item}\n"}
      end

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
