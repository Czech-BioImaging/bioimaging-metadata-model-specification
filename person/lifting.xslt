<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0" xmlns:ccmm="https://schema.ccmm.cz/research-data/1.1" xmlns:c="https://schemas.dataspecer.com/xsd/core/" xmlns:ns0="https://model.ccmm.cz/vocabulary/ccmm#" xmlns:ns1="http://xmlns.com/foaf/0.1/" xmlns:ns2="http://www.w3.org/2006/vcard/ns#" xmlns:ns3="http://www.w3.org/ns/dcat#">
  <xsl:import href="https://model.ccmm.cz/research-data/person/lifting.xslt"/>
  <xsl:import href="../identifier/lifting.xslt"/>
  <xsl:import href="../contact-details/lifting.xslt"/>
  <xsl:import href="../organization/lifting.xslt"/>
  <xsl:import href="../address/lifting.xslt"/>
  <xsl:import href="../identifier-scheme/lifting.xslt"/>
  <xsl:output method="xml" version="1.0" encoding="utf-8" media-type="application/rdf+xml" indent="yes"/>
  <xsl:template match="/ccmm:person">
    <rdf:RDF>
      <xsl:variable name="result" as="element()*">
        <xsl:call-template name="_bb519790-b579-4722-afc1-93e0f382a3ed_002fclass-1762017242451-3954-d430-aa66"/>
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
  <xsl:template name="_bb519790-b579-4722-afc1-93e0f382a3ed_002fclass-1762017242451-3954-d430-aa66">
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
      <rdf:type rdf:resource="http://www.w3.org/ns/prov#Person"/>
      <xsl:copy-of select="$arc"/>
      <xsl:for-each select="ccmm:identifier">
        <ns0:hasIdentifier>
          <xsl:call-template name="_63142e8a-1efd-4ecc-baa4-55474e96d035_002fclass-1742340169817-84a9-ded1-a656"/>
        </ns0:hasIdentifier>
      </xsl:for-each>
      <xsl:for-each select="ccmm:name">
        <ns1:name rdf:datatype="http://www.w3.org/2001/XMLSchema#string">
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="."/>
        </ns1:name>
      </xsl:for-each>
      <xsl:for-each select="ccmm:given_name">
        <ns2:given-name rdf:datatype="http://www.w3.org/2001/XMLSchema#string">
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="."/>
        </ns2:given-name>
      </xsl:for-each>
      <xsl:for-each select="ccmm:family_name">
        <ns2:family-name rdf:datatype="http://www.w3.org/2001/XMLSchema#string">
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="."/>
        </ns2:family-name>
      </xsl:for-each>
      <xsl:for-each select="ccmm:contact_point">
        <ns3:contactPoint>
          <xsl:call-template name="_625173c9-9d34-4ae7-a93b-0f65ce4ecd63_002fclass-1742234373952-7a86-df18-a582"/>
        </ns3:contactPoint>
      </xsl:for-each>
      <xsl:for-each select="ccmm:affiliation">
        <ns0:hasAffiliation>
          <xsl:call-template name="_4aeb1161-45da-4adc-89ad-e9f6cd40d300_002fclass-1744871355397-62d0-acf0-af09"/>
        </ns0:hasAffiliation>
      </xsl:for-each>
    </rdf:Description>
  </xsl:template>
  <xsl:template match="@*|*"/>
</xsl:stylesheet>
