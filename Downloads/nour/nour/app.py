from flask import Flask, render_template, request
from lxml import etree

app = Flask(__name__)

@app.route("/")
def index():
    search_query = request.args.get("search", "").lower()
    tree = etree.parse("ArtistAlgerian.xml")
    root = tree.getroot()

    # On prépare tous les albums une seule fois avec les références
    album_map = {}
    for album in root.findall("album"):
        titre = album.find("titre").text
        annee = album.get("annee")
        ref_artist = album.find("ref-artiste").get("ref")
        tracks = [chanson.text for chanson in album.find("chansons").findall("chanson")]
        
        if ref_artist not in album_map:
            album_map[ref_artist] = []
        album_map[ref_artist].append({
            "title": titre,
            "year": annee,
            "tracks": tracks
        })

    # On récupère tous les artistes
    artists = []
    for artist in root.findall("artiste"):
        artist_id = artist.get("no")
        name = artist.get("nom")
        city = artist.get("ville")
        biography = artist.find("biographie").text
        website = artist.find("site").get("url")

        if search_query in name.lower():
            albums = album_map.get(artist_id, [])
            artists.append({
                "name": name,
                "city": city,
                "biography": biography,
                "website": website,
                "albums": albums
            })

    return render_template("index.html", artists=artists)

@app.route("/xslt")
def xslt():
    dom = etree.parse("ArtistAlgerian.xml")
    xslt = etree.parse("artist_transformation.xsl")
    transform = etree.XSLT(xslt)
    result = transform(dom)
    return str(result)

if __name__ == "__main__":
    app.run(debug=True)
