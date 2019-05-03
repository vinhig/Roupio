require "../Content"
require "../Page"
require "kemal"

# Cloud page. Easily shared and stored important document through the association.
class Cloud < Page
  def get(env, db)
    # Left navbar different possible links.
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
      # Ask the database for owned files
      db.get_all_file(@user.pseudo).each do |file|
        file_to_add = HTML::FileLink.new(file["name"], false, "cloud/get_file?id=#{file["hash"]}", file["name"])
        case file["category"]
        when "Projets"
          projet.add_element(file_to_add)
        when "Formations"
          formations.add_element(file_to_add)
        when "Events"
          events.add_element(file_to_add)
        when "Administration"
          administration.add_element(file_to_add)
        when "Communication"
          communication.add_element(file_to_add)
        when "Autres"
          autres.add_element(file_to_add)
        end
      end
      # Append all objects to @content
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
      form.add_element(HTML::Header4.new("Header4-upload-file", "Visibilité :"))
      form.add_element(HTML::Select.new("visibility", ["Rien que moi", "Membres adhérants", "Membres effectifs", "Administrateurs", "Secrétaire, trésorier et président"]))
      pa = HTML::Paragraph.new("submit-p", "")
      pa.add_element(HTML::Input.new("submit", "submit", "Envoyer"))
      pa.attributes["style"] = "text-align: center"
      form.add_element(pa)
      upload.add_element(form)
      box.add_element(upload)
    when "shared"
      card = HTML::Card.new("Card")
      card.add_element(HTML::Header2.new("test", "Fichiers partagés"))
      caption = HTML::Paragraph.new("caption-help", "Liste des fichiers auquels vous avez accès en étant #{@user.level}")
      # Build the file tree
      root = HTML::FileLink.new("root", true, "", "")
      projet = HTML::FileLink.new("projet", true, "", "Projets")
      administration = HTML::FileLink.new("administration", true, "", "Administration")
      formations = HTML::FileLink.new("formations", true, "", "Formations")
      events = HTML::FileLink.new("events", true, "", "Events")
      communication = HTML::FileLink.new("communication", true, "", "Communication")
      autres = HTML::FileLink.new("autres", true, "", "Autres")
      db.get_shared_file(@user.pseudo, @user.level).each do |file|
        file_to_add = HTML::FileLink.new(file["name"], false, "cloud/get_file?id=#{file["hash"]}", file["name"])
        case file["category"]
        when "Projets"
          projet.add_element(file_to_add)
        when "Formations"
          formations.add_element(file_to_add)
        when "Events"
          events.add_element(file_to_add)
        when "Administration"
          administration.add_element(file_to_add)
        when "Communication"
          communication.add_element(file_to_add)
        when "Autres"
          autres.add_element(file_to_add)
        end
      end
      # Append all objects to @content
      root.add_element([projet, administration, communication, formations, events, autres])
      card.add_element(caption)
      card.add_element(root)
      box.add_element(card)
    when "res"
      card = HTML::Card.new("Card")
      card.add_element(HTML::Header2.new("test", "Ressources partagées"))
      box.add_element(card)
    when "main"
      card = HTML::Card.new("Card")
      card.add_element(HTML::Header2.new("test", "Le cloud!"))
      caption = HTML::Paragraph.new("caption-explain", "Le cloud vous permet de partager des fichiers avec les différents membres de l'association, d'archiver des documents importants ainsi que de partager des ressources et des liens que vous jugez utiles.")
      card.add_element(caption)
      box.add_element(card)
    when "get_file"
      # An user asks to access a certain file.
      # Check if the file exists and if the user can take it.
      if env.params.query.has_key?("id") || File.exists?("public/uploads/#{env.params.query["id"]}")
        # Get and check the file
        file = db.get_and_check(@user.pseudo, env.params.query["id"], @user.level)
        if file != ""
          send_file env, "public/uploads/#{env.params.query["id"]}", filename: file, disposition: "attachment"
        else
          env.redirect "/cloud/my?msg=1"
        end
      else
      end
    end
    @content.add_element(box)
  end

  def post(env, db)
    case @url
    when "upload"
      # We must store a file
      category = env.params.body["category"]
      visibility = env.params.body["visibility"]
      case visibility
      when "Rien que moi"
        visibility = "private"
      when "Membres adhérants"
        visibility = "adherant;effectif;admin;sky"
      when "Membres effectifs"
        visibility = "effectif;admin;sky"
      when "Administrateurs"
        visibility = "admin;sky"
      when "Secrétaire, trésorier et président"
        visibility = "sky"
      end
      file = env.params.files["file_to_upload"].tempfile
      content = file.gets_to_end
      file_name = env.params.body["file_name"]
      # Digest the content and the pseudo of the user to avoid
      # storing multiple file with same content
      md5 = OpenSSL::Digest.new("md5")
      md5.update(@user.pseudo + content)
      path = Kemal.config.public_folder + "/uploads/" + md5.to_s
      # File already exists
      if File.exists?(path)
        env.redirect("my?msg=0")
      else
        File.write(path, content)
        db.store_new_file(file_name, @user.pseudo, md5.to_s, category, visibility)
        env.redirect("my")
      end
    end
  end
end
