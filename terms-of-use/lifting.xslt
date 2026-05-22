<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0" xmlns:ccmm="https://schema.ccmm.cz/research-data/1.1" xmlns:c="https://schemas.dataspecer.com/xsd/core/" xmlns:ns0="http://purl.org/dc/terms/" xmlns:ns1="http://www.w3.org/ns/dcat#">
  <xsl:import href="https://model.ccmm.cz/research-data/terms-of-use/lifting.xslt"/>
  <xsl:import href="../access-rights/lifting.xslt"/>
  <xsl:import href="../license-document/lifting.xslt"/>
  <xsl:import href="../organization/lifting.xslt"/>
  <xsl:import href="../person/lifting.xslt"/>
  <xsl:import href="../identifier/lifting.xslt"/>
  <xsl:import href="../contact-details/lifting.xslt"/>
  <xsl:import href="../address/lifting.xslt"/>
  <xsl:import href="../identifier-scheme/lifting.xslt"/>
  <xsl:output method="xml" version="1.0" encoding="utf-8" media-type="application/rdf+xml" indent="yes"/>
  <xsl:template match="/ccmm:terms_of_use">
    <rdf:RDF>
      <xsl:variable name="result" as="element()*">
        <xsl:call-template name="_94bd13ce-5dae-4ba4-af6f-1215a8e4ba57_002fclass-1742235510107-a209-3731-aa0c"/>
      </xsl:variable>
      <xsl:for-each select="$result">
        <xsl:copy>
          <xsl:call-template name="remove-top"/>
        </xsl:copy>
      </xsl:for-each>
      <xsl:for-each select="$result//top-level/node()">
        <xsl:copy>
          <xsl:call-template name="remove-top"/>
        </xsl:copy>
      </xsl:for-each>
    </rdf:RDF>
  </xsl:template>
  <xsl:template match="@xml:lang">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template name="remove-top">
    <xsl:for-each select="@*">
      <xsl:copy/>
    </xsl:for-each>
    <xsl:for-each select="node()[not(. instance of element(top-level))]">
      <xsl:copy>
        <xsl:call-template name="remove-top"/>
      </xsl:copy>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="_94bd13ce-5dae-4ba4-af6f-1215a8e4ba57_002fclass-1742235510107-a209-3731-aa0c">
    <xsl:param name="arc" select="()"/>
    <xsl:param name="no_iri" select="false()"/>
    <rdf:Description>
      <xsl:apply-templates select="@*"/>
      <xsl:variable name="id">
        <id>
          <xsl:choose>
            <xsl:when test="ccmm:iri and not($no_iri)">
              <xsl:attribute name="rdf:about">
                <xsl:value-of select="ccmm:iri"/>
              </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="rdf:nodeID">
                <xsl:value-of select="generate-id()"/>
              </xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
        </id>
      </xsl:variable>
      <xsl:copy-of select="$id//@*"/>
      <rdf:type rdf:resource="https://model.ccmm.cz/vocabulary/datacite#Rights"/>
      <xsl:copy-of select="$arc"/>
      <xsl:for-each select="ccmm:access_rights">
        <ns0:accessRights>
          <xsl:call-template name="_06b19280-5dd0-4c08-84d5-1afa55aee122_002fclass-1747685414671-e5e1-7f82-b427"/>
        </ns0:accessRights>
      </xsl:for-each>
      <xsl:for-each select="ccmm:license">
        <ns0:license>
          <xsl:call-template name="_ed82ce23-1bfb-465d-9996-7f6418ce2137_002fclass-1747640270910-1022-e495-9645"/>
        </ns0:license>
      </xsl:for-each>
      <xsl:for-each select="ccmm:description">
        <ns0:description>
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="."/>
        </ns0:description>
      </xsl:for-each>
      <xsl:for-each select="ccmm:contact_point">
        <ns1:contactPoint>
          <xsl:variable name="type" select="resolve-QName(@xsi:type,.)"/>
          <xsl:variable name="types" as="element()*">
            <ccmm:organization/>
            <ccmm:person/>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="$type=node-name($types[1])">
              <xsl:call-template name="_4aeb1161-45da-4adc-89ad-e9f6cd40d300_002fclass-1744871355397-62d0-acf0-af09"/>
            </xsl:when>
            <xsl:when test="*[node-name(.) = node-name($types[1])]">
              <xsl:for-each select="*[node-name(.) = node-name($types[1])]">
                <xsl:call-template name="_4aeb1161-45da-4adc-89ad-e9f6cd40d300_002fclass-1744871355397-62d0-acf0-af09"/>
              </xsl:for-each>
            </xsl:when>
            <xsl:when test="$type=node-name($types[2])">
              <xsl:call-template name="_bb519790-b579-4722-afc1-93e0f382a3ed_002fclass-1762017242451-3954-d430-aa66"/>
            </xsl:when>
            <xsl:when test="*[node-name(.) = node-name($types[2])]">
              <xsl:for-each select="*[node-name(.) = node-name($types[2])]">
                <xsl:call-template name="_bb519790-b579-4722-afc1-93e0f382a3ed_002fclass-1762017242451-3954-d430-aa66"/>
              </xsl:for-each>
            </xsl:when>
          </xsl:choose>
        </ns1:contactPoint>
      </xsl:for-each>
    </rdf:Description>
  </xsl:template>
  <xsl:template match="@*|*"/>
</xsl:stylesheet>
