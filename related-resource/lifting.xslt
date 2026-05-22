<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0" xmlns:ccmm="https://schema.ccmm.cz/research-data/1.1" xmlns:c="https://schemas.dataspecer.com/xsd/core/" xmlns:ns0="https://model.ccmm.cz/vocabulary/ccmm#" xmlns:ns1="http://purl.org/dc/terms/">
  <xsl:import href="https://model.ccmm.cz/research-data/related-resource/lifting.xslt"/>
  <xsl:import href="../identifier/lifting.xslt"/>
  <xsl:import href="../alternate-title/lifting.xslt"/>
  <xsl:import href="../resource-to-agent-relationship/lifting.xslt"/>
  <xsl:import href="../time-reference/lifting.xslt"/>
  <xsl:import href="../resource-type/lifting.xslt"/>
  <xsl:import href="../resource-relation-type/lifting.xslt"/>
  <xsl:import href="../time-interval/lifting.xslt"/>
  <xsl:import href="../time-instant/lifting.xslt"/>
  <xsl:import href="../date-type/lifting.xslt"/>
  <xsl:import href="../organization/lifting.xslt"/>
  <xsl:import href="../person/lifting.xslt"/>
  <xsl:import href="../resource-agent-role-type/lifting.xslt"/>
  <xsl:import href="../contact-details/lifting.xslt"/>
  <xsl:import href="../address/lifting.xslt"/>
  <xsl:import href="../identifier-scheme/lifting.xslt"/>
  <xsl:import href="../alternate-title-type/lifting.xslt"/>
  <xsl:output method="xml" version="1.0" encoding="utf-8" media-type="application/rdf+xml" indent="yes"/>
  <xsl:template match="/ccmm:related_resource">
    <rdf:RDF>
      <xsl:variable name="result" as="element()*">
        <xsl:call-template name="_b4ae2345-19f4-483f-ab17-df992dc1f370_002fclass-1765909420903-5abd-5a0e-810e"/>
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
  <xsl:template name="_b4ae2345-19f4-483f-ab17-df992dc1f370_002fclass-1765909420903-5abd-5a0e-810e">
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
      <rdf:type rdf:resource="http://www.w3.org/2000/01/rdf-schema#Resource"/>
      <xsl:copy-of select="$arc"/>
      <xsl:for-each select="ccmm:identifier">
        <ns0:hasIdentifier>
          <xsl:call-template name="_63142e8a-1efd-4ecc-baa4-55474e96d035_002fclass-1742340169817-84a9-ded1-a656"/>
        </ns0:hasIdentifier>
      </xsl:for-each>
      <xsl:for-each select="ccmm:title">
        <ns1:title rdf:datatype="http://www.w3.org/2001/XMLSchema#string">
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="."/>
        </ns1:title>
      </xsl:for-each>
      <xsl:for-each select="ccmm:alternate_title">
        <ns0:hasAlternateTitle>
          <xsl:call-template name="_0dc51c4f-16a8-4044-8c23-d13b5cc659ee_002fclass-1742340187136-c36a-9f4c-b745"/>
        </ns0:hasAlternateTitle>
      </xsl:for-each>
      <xsl:for-each select="ccmm:resource_url">
        <ns0:resourceUrl rdf:datatype="http://www.w3.org/2001/XMLSchema#anyURI">
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="."/>
        </ns0:resourceUrl>
      </xsl:for-each>
      <xsl:for-each select="ccmm:qualified_relation">
        <ns0:qualifiedRelation>
          <xsl:call-template name="_405f2155-1c8a-4ecb-b4b6-c5b9a54c1817_002fclass-1742235557653-64a2-513a-97fe"/>
        </ns0:qualifiedRelation>
      </xsl:for-each>
      <xsl:for-each select="ccmm:time_reference">
        <ns0:hasTimeReference>
          <xsl:call-template name="_fd449048-ce75-43e2-a8ba-c300bfc94c6e_002fclass-1762083331490-ea8b-4a3a-bd65"/>
        </ns0:hasTimeReference>
      </xsl:for-each>
      <xsl:for-each select="ccmm:resource_type">
        <ns1:type>
          <xsl:call-template name="_f76e19e0-918a-4457-80d8-86243eebd95a_002fclass-1747685065285-430a-9d52-9477"/>
        </ns1:type>
      </xsl:for-each>
      <xsl:for-each select="ccmm:resource_relation_type">
        <ns0:hasType>
          <xsl:call-template name="_5a026c18-c9c5-489a-bb64-5ba449edc3ce_002fclass-1747685037448-1c9b-f7fc-b4be"/>
        </ns0:hasType>
      </xsl:for-each>
    </rdf:Description>
  </xsl:template>
  <xsl:template match="@*|*"/>
</xsl:stylesheet>
