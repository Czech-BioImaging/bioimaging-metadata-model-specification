<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0" xmlns:ccmm="https://schema.ccmm.cz/research-data/1.1" xmlns:c="https://schemas.dataspecer.com/xsd/core/" xmlns:ns0="http://purl.org/dc/terms/" xmlns:ns1="https://model.ccmm.cz/vocabulary/ccmm#">
  <xsl:import href="https://model.ccmm.cz/research-data/metadata-record/lifting.xslt"/>
  <xsl:import href="../language-system/lifting.xslt"/>
  <xsl:import href="../resource-to-agent-relationship/lifting.xslt"/>
  <xsl:import href="../application-profile/lifting.xslt"/>
  <xsl:import href="../repository/lifting.xslt"/>
  <xsl:import href="../organization/lifting.xslt"/>
  <xsl:import href="../person/lifting.xslt"/>
  <xsl:import href="../resource-agent-role-type/lifting.xslt"/>
  <xsl:import href="../identifier/lifting.xslt"/>
  <xsl:import href="../contact-details/lifting.xslt"/>
  <xsl:import href="../address/lifting.xslt"/>
  <xsl:import href="../identifier-scheme/lifting.xslt"/>
  <xsl:output method="xml" version="1.0" encoding="utf-8" media-type="application/rdf+xml" indent="yes"/>
  <xsl:template match="/ccmm:metadata_record">
    <rdf:RDF>
      <xsl:variable name="result" as="element()*">
        <xsl:call-template name="_ccc1c992-18c2-4f71-b438-54e0da3c9534_002fclass-1742339770114-2bc2-3bdc-a309"/>
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
  <xsl:template name="_ccc1c992-18c2-4f71-b438-54e0da3c9534_002fclass-1742339770114-2bc2-3bdc-a309">
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
      <rdf:type rdf:resource="http://www.w3.org/ns/dcat#CatalogRecord"/>
      <xsl:copy-of select="$arc"/>
      <xsl:for-each select="ccmm:language">
        <ns0:language>
          <xsl:call-template name="_f3bf77ad-9a84-4a1c-8556-a097c7f5a02d_002fclass-1747685830295-de50-b2ac-bb47"/>
        </ns0:language>
      </xsl:for-each>
      <xsl:for-each select="ccmm:qualified_relation">
        <xsl:call-template name="_405f2155-1c8a-4ecb-b4b6-c5b9a54c1817_002fclass-1742235557653-64a2-513a-97fe"/>
      </xsl:for-each>
      <xsl:for-each select="ccmm:date_updated">
        <ns0:modified rdf:datatype="http://www.w3.org/2001/XMLSchema#date">
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="."/>
        </ns0:modified>
      </xsl:for-each>
      <xsl:for-each select="ccmm:date_created">
        <ns0:created rdf:datatype="http://www.w3.org/2001/XMLSchema#date">
          <xsl:apply-templates select="@*"/>
          <xsl:value-of select="."/>
        </ns0:created>
      </xsl:for-each>
      <xsl:for-each select="ccmm:conforms_to_standard">
        <ns0:conformsTo>
          <xsl:call-template name="_aba531cb-0df0-48be-8090-1bb17eba35dc_002fclass-1742235803801-3bb0-3064-a2dc"/>
        </ns0:conformsTo>
      </xsl:for-each>
      <xsl:for-each select="ccmm:original_repository">
        <ns1:originalRepository>
          <xsl:call-template name="_04f1c6e5-eb96-4a45-b687-c9d66f857f08_002fclass-1742339809761-c64b-cd69-80de"/>
        </ns1:originalRepository>
      </xsl:for-each>
    </rdf:Description>
  </xsl:template>
  <xsl:template match="@*|*"/>
</xsl:stylesheet>
