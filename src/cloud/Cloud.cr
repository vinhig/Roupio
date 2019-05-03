require "../Content"
require "../Page"

# Cloud page
class Cloud < Page
  def load(db)
    links = [
      ["cloud/my", "Mes fichiers"],
      ["cloud/shared", "Fichiers partagés"],
      ["cloud/res", "Ressources partagées"],
    ]
    side = HTML::SidePanel.new("cloud-id", "Cloud", links)
    @content.add_element(side)
    box = HTML::ScrollBox.new("ScrollBox")

    case @url
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
      administration = HTML::FileLink.new("administration", true, "", "Administration")
      formations = HTML::FileLink.new("formations", true, "", "Formations")
      events = HTML::FileLink.new("events", true, "", "Events")
      communication = HTML::FileLink.new("communication", true, "", "Communication")
      autres = HTML::FileLink.new("autres", true, "", "Autres")
      db.get_all_file(@user.pseudo).each do |file|
        case file["category"]
        when "Projets"
          projet.add_element(HTML::FileLink.new(file["name"], false, file["hash"], file["name"]))
        when "Formations"
          formations.add_element(HTML::FileLink.new(file["name"], false, file["hash"], file["name"]))
        when "Events"
          events.add_element(HTML::FileLink.new(file["name"], false, file["hash"], file["name"]))
        when "Administration"
          administration.add_element(HTML::FileLink.new(file["name"], false, file["hash"], file["name"]))
        when "Communication"
          communication.add_element(HTML::FileLink.new(file["name"], false, file["hash"], file["name"]))
        when "Autres"
          autres.add_element(HTML::FileLink.new(file["name"], false, file["hash"], file["name"]))
        end
      end
      # Append all object to content
      root.add_element([projet, administration, communication, formations, events, autres])
      card.add_element(caption)
      card.add_element(root)
      box.add_element(card)
      # Upload a file card
      upload = HTML::Card.new("card-upload")
      form = HTML::Form.new("form-new-file", "post", "cloud/upload")
      form.add_element(HTML::Header2.new("Header2-upload-file", "Ajouter un fichier"))
      form.add_element(HTML::Header4.new("Header4-upload-file", "Catégorie :"))
      form.add_element(HTML::Select.new("category", ["Projets", "Events", "Formations", "Administration", "Communication", "Autres"]))
      form.add_element(HTML::Header4.new("Header4-upload-file", "Fichier :"))
      file_upload = HTML::Input.new("file_to_upload", "file", "Fichier")
      file_upload.attributes["onchange"] = "bindFileName(event, \"file_name\");"
      form.add_element(file_upload)
      form.add_element(HTML::Input.new("file_name", "hidden", ""))
      pa = HTML::Paragraph.new("submit-p", "")
      pa.add_element(HTML::Input.new("submit", "submit", "Envoyer"))
      pa.attributes["style"] = "text-align: center"
      form.add_element(pa)
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

  def enter(env, db)
    case @url
    when "upload"
      # We must store a file
      category = env.params.body["category"]
      file = env.params.files["file_to_upload"].tempfile
      content = file.gets_to_end
      file_name = env.params.body["file_name"]
      md5 = OpenSSL::Digest.new("md5")
      md5.update(@user.pseudo + content)
      path = Kemal.config.public_folder + "/uploads/" + md5.to_s
      if File.exists?(path)
        env.redirect("my?msg=0")
      else
        File.write(path, content)
        db.store_new_file(file_name, @user.pseudo, md5.to_s, category)
        env.redirect("my")
      end
    end
  end
end
