<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/CD">
        <html>
            <head>
                <title>Liste des artistes algériens</title>
                <style>
                    body { font-family: Arial; background: #f9f9f9; padding: 20px; }
                    .artiste { background: white; padding: 15px; margin-bottom: 20px; border-radius: 10px; box-shadow: 0 2px 5px #ccc; }
                    h2 { color: #007bff; }
                    .label { font-weight: bold; }
                    ul { padding-left: 20px; }
                    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
                    th, td { border: 1px solid #ddd; padding: 8px; }
                    th { background-color: #007bff; color: white; }
                </style>
            </head>
            <body>
                <h1>🎶 Liste des artistes algériens 🎶</h1>

                <!-- Loop through each artist -->
                <xsl:for-each select="artiste">
                    <div class="artiste">
                        <h2><xsl:value-of select="@nom"/></h2>
                        <p><span class="label">📍 Ville:</span> <xsl:value-of select="@ville"/></p>
                        <p><span class="label">🌐 Site web:</span> 
                            <a href="{site/@url}" target="_blank">
                                <xsl:value-of select="site/@url"/>
                            </a>
                        </p>
                        <p><span class="label">📖 Biographie:</span> <xsl:value-of select="biographie"/></p>

                        <xsl:variable name="idArtiste" select="@no"/>

                        <!-- Albums of this artist -->
                        <xsl:for-each select="../album[ref-artiste/@ref = $idArtiste]">
                            <h3>💿 Album: <xsl:value-of select="titre"/></h3>
                            <p><span class="label">Année:</span> <xsl:value-of select="@annee"/></p>
                            <p><span class="label">Chansons:</span></p>
                            <ul>
                                <xsl:for-each select="chansons/chanson">
                                    <li><xsl:value-of select="."/></li>
                                </xsl:for-each>
                            </ul>
                        </xsl:for-each>
                    </div>
                </xsl:for-each>

            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
