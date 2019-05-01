# Namespace that groups HTML relative elements and objects.
module HTML
  # A Content is a HTML document that is renderable and modifiable.
  class Content
    @elements : Array(HTMLElement)
    @text : String

    # Init an empty HTML document from the 'template.html' file.
    def initialize
      @elements = Array(HTMLElement).new
      @text = File.read("src/template.html")
    end

    # Return the corresponding element to id.
    def get_element(id : String)
      @elements.each do |element|
        # Return the element unless it has a corresponding id
        if element.id == id
          @element
        end
      end
    end

    # Add an HTML element to the list.
    def add_element(element : HTMLElement)
      # Add a new element to the list
      @elements.push(element)
    end

    # Render the current content. Return a string representing the HTML document source code.
    def render
      body = ""
      # Render all child of the document
      @elements.each do |element|
        body += element.render
      end
      # Fill the template with our rendered content
      @text.sub("{{ content }}", body)
    end
  end

  # Empty HTML element without any characteristics.
  class HTMLElement
    property id : String
    @tag : String
    @innerText : String
    @attributes : Hash(String, Int32 | String)
    @children : Array(HTMLElement)

    # Init an empty HTML element. Be aware, an empty element is renderable but will not work in browser.
    def initialize(@id)
      @tag = ""
      @innerText = ""
      @id
      @attributes = Hash(String, Int32 | String).new
      @children = Array(HTMLElement).new
    end

    # Render the current element. Return a string representing the element markup.
    def render
      text = "<#{@tag} id='#{@id}' "
      @attributes.each do |att, cont|
        text += "#{att}='#{cont}' "
      end
      text += ">#{@innerText}"
      @children.each do |child|
        text += child.render
      end
      text += "</#{@tag}> "
    end

    # Add an HTML element to the list of children.
    def add_element(element : HTMLElement)
      # Add a new element to the list of children
      @children.push(element)
    end
  end

  # A 'a' HTML element.
  #
  # ```html
  # <a id='id' href='/path/to/an/awesome/page'></a>
  # ```
  class NavLink < HTMLElement
    # Init a 'a' element from given characteristics.
    def initialize(@id, href : String, text : String)
      super(@id)
      @tag = "a"
      @attributes["href"] = href
      @innerText = text
    end
  end

  # A 'p' HTML element.
  #
  # ```html
  # <p id='id'></a>
  # ```
  class Paragraph < HTMLElement
    # Init a 'a' element from given characteristics.
    def initialize(@id, text : String)
      super(@id)
      @tag = "p"
      @innerText = text
    end
  end
end
