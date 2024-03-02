<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML, 3rd Edition
   Tutorial 5
   Tutorial Case

   Chesterton Financial XSL Style Sheet
   Author: Josh Bricker
   Date:   03/01/2024

   Filename:         stock.xsl
   Supporting Files: down.png, same.png, stock.css, up.png

-->


<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

   <!-- Root template -->
   <xsl:template match="/">
      <html>
         <head>
            <title>Portfolio Stocks</title>
            <link href="stock.css" rel="stylesheet" type="text/css" />
         </head>
         <body>
            <header>
               <h1>Chesterton Financial</h1>
               <h2>Portfolio Stocks</h2>
               <section>
                <h1>Utilities</h1>
                <xsl:apply-templates select="portfolio/stock[category='Utilities']">
                    <xsl:sort select="sName" />
                </xsl:apply-templates>
                  <xsl:for-each select="portfolio/stock">
                  <article>
                     <h1>
                        <xsl:apply-templates select="portfolio/stock">
                        <xsl:sort select="sName" />
                    </xsl:apply-templates>

                     </h1>
                  </article>
               </xsl:for-each>
                  Last Updated:
                  <xsl:value-of select="portfolio/date" /> at
                  <xsl:value-of select="portfolio/time" />
               </section>
            </header>
            <section>
                <xsl:apply-templates select="portfolio/stock[category='Industrials']">
                <xsl:sort select="sName" />
            </xsl:apply-templates>
               <article>
                  <h1>
                     <xsl:apply-templates select="portfolio/stock" />
                  </h1>
               </article>
            </section>
            <h1>Transportation</h1>
            <xsl:apply-templates select="portfolio/stock[category='Transportation']">
                <xsl:sort select="sName" />
            </xsl:apply-templates>
         </body>
      </html>
   </xsl:template>
   <xsl:template match="stock">
      <article>
         <h1>
            <xsl:value-of select="sName" />
            (<xsl:value-of select="sName/@symbol" />)
         </h1>
         <img src="{sName/@symbol}.png" alt="3 month history" />

         <p>
            <xsl:value-of select="description" />
         </p>
         <hr />
         <xsl:apply-templates select="today" />
      </article>
   </xsl:template>
   
   <xsl:template match="today">
      <table>
          <thead>
              <tr>
                  <th colspan="6">Current Stock Values</th>
              </tr>
              <tr>
                  <th></th>
                  <th>Current</th>
                  <th>Open</th>
                  <th>High</th>
                  <th>Low</th>
                  <th>Volume</th>
              </tr>
          </thead>
          <tbody>
              <tr>
                  <td>
                      <xsl:choose>
                          <xsl:when test="@current &lt; @open">
                              <img src="down.png" alt="down" />
                          </xsl:when>
                          <xsl:when test="@current > @open">
                              <img src="up.png" alt="up" />
                          </xsl:when>
                          <xsl:otherwise>
                              <img src="same.png" alt="same" />
                          </xsl:otherwise>
                      </xsl:choose>
                  </td>
                  <xsl:apply-templates select="@current" />
                  <xsl:apply-templates select="@open" />
                  <xsl:apply-templates select="@high" />
                  <xsl:apply-templates select="@low" />
                  <xsl:apply-templates select="@vol" />
              </tr>
          </tbody>
      </table>
  </xsl:template>