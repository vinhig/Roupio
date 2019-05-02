require "../Content"
require "../Page"

# Cloud page
class Cloud < Page
  def load(url : String)
    links = [
      ["cloud/my", "Mes fichiers"],
      ["cloud/shared", "Fichiers partagés"],
      ["cloud/res", "Ressources partagées"],
    ]
    side = HTML::SidePanel.new("cloud-id", "Cloud", links)
    @content.add_element(side)
    box = HTML::ScrollBox.new("ScrollBox")
    card = HTML::Card.new("Card")
    case url
    when "my"
      # Adding little caption to explain the page
      caption = HTML::Paragraph.new("caption-help", "Liste des fichiers dont vous êtes l'auteur.")
      # Adding the Box and the Card
      card.add_element(HTML::Header2.new("test", "Mes fichiers"))
      # Build the file tree
      root = HTML::FileLink.new("root", true, "", "")
      projet = HTML::FileLink.new("projet", true, "", "Projets")
      projet.add_element(HTML::FileLink.new("root", false, "pdf.pdf", "pdf.pdf"))
      projet.add_element(HTML::FileLink.new("root", false, "autre.pdf", "autre.pdf"))
      # Append all object to content
      root.add_element(HTML::FileLink.new("root", false, "test.jpg", "test.jpg"))
      root.add_element(projet)
      card.add_element(caption)
      card.add_element(root)
    when "shared"
      card.add_element(HTML::Header2.new("test", "Fichiers partagées"))
    when "res"
      card.add_element(HTML::Header2.new("test", "Ressources partagées"))
    when "main"
      card.add_element(HTML::Header2.new("test", "Page d'accueil du Cloud"))
    end
    box.add_element(card)
    @content.add_element(box)
  end
end
