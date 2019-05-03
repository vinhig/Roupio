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

    case url
    when "my"
      # List of files card
      card = HTML::Card.new("Card")
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
      box.add_element(card)
      # Upload a file card
      upload = HTML::Card.new("card-upload")
      form = HTML::Form.new("form-new-file", "post", "cloud/upload")
      form.add_element(HTML::Header2.new("Header2-upload-file", "Ajouter un fichier"))
      form.add_element(HTML::Header4.new("Header4-upload-file", "Catégorie :"))
      form.add_element(HTML::Select.new("category", ["Projets", "Events", "Formations", "Administration", "Autres"]))
      form.add_element(HTML::Header4.new("Header4-upload-file", "Fichier :"))
      form.add_element(HTML::Input.new("file", "file", "Fichier"))
      form.add_element(HTML::Input.new("submit", "submit", "Envoyer"))
      upload.add_element(form)
      box.add_element(upload)
    when "shared"
      card = HTML::Card.new("Card")
      card.add_element(HTML::Header2.new("test", "Fichiers partagées"))
      box.add_element(card)
    when "res"
      card = HTML::Card.new("Card")
      card.add_element(HTML::Header2.new("test", "Ressources partagées"))
      box.add_element(card)
    when "main"
      card = HTML::Card.new("Card")
      card.add_element(HTML::Header2.new("test", "Le cloud!"))
      caption = HTML::Paragraph.new("caption-explain", "Le cloud vous permet de partager des fichiers avec les différents membres de l'association, pour archiver des documents importants ainsi que partager des ressources et des liens que vous jugez utiles.")
      card.add_element(caption)
      box.add_element(card)
    end

    @content.add_element(box)
  end
end
