<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sp="http://www.w3.org/2005/sparql-results#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0" xmlns:ccmm="https://schema.ccmm.cz/research-data/1.1" xmlns:c="https://schemas.dataspecer.com/xsd/core/">
  <xsl:import href="https://model.ccmm.cz/research-data/terms-of-use/lowering.xslt"/>
  <xsl:import href="../access-rights/lowering.xslt"/>
  <xsl:import href="../license-document/lowering.xslt"/>
  <xsl:import href="../organization/lowering.xslt"/>
  <xsl:import href="../person/lowering.xslt"/>
  <xsl:import href="../identifier/lowering.xslt"/>
  <xsl:import href="../contact-details/lowering.xslt"/>
  <xsl:import href="../address/lowering.xslt"/>
  <xsl:import href="../identifier-scheme/lowering.xslt"/>
  <xsl:output method="xml" version="1.0" encoding="utf-8" indent="yes"/>
  <xsl:param name="subj" select="'s'"/>
  <xsl:param name="pred" select="'p'"/>
  <xsl:param name="obj" select="'o'"/>
  <xsl:variable name="type" select="'http://www.w3.org/1999/02/22-rdf-syntax-ns#type'"/>
  <xsl:function name="c:id-key">
    <xsl:param name="node"/>
    <xsl:value-of select="concat(namespace-uri($node),'|',local-name($node),'|',string($node))"/>
  </xsl:function>
  <xsl:template match="/sp:sparql">
    <xsl:for-each-group select="sp:results/sp:result[sp:binding[@name=$pred]/sp:uri/text()=$type and sp:binding[@name=$obj]/sp:uri/text()=&#34;https://model.ccmm.cz/vocabulary/datacite#Rights&#34;]" group-by="c:id-key(sp:binding[@name=$subj]/*[1])">
      <xsl:apply-templates select="current-group()[1]"/>
    </xsl:for-each-group>
  </xsl:template>
  <xsl:template match="sp:result[sp:binding[@name=$pred]/sp:uri/text()=$type and sp:binding[@name=$obj]/sp:uri/text()=&#34;https://model.ccmm.cz/vocabulary/datacite#Rights&#34;]">
    <ccmm:terms_of_use>
      <xsl:call-template name="_94bd13ce-5dae-4ba4-af6f-1215a8e4ba57_002fclass-1742235510107-a209-3731-aa0c">
        <xsl:with-param name="id">
          <xsl:copy-of select="sp:binding[@name=$subj]/*"/>
        </xsl:with-param>
      </xsl:call-template>
    </ccmm:terms_of_use>
  </xsl:template>
  <xsl:template match="@xml:lang">
    <xsl:copy-of select="."/>
  </xsl:template>
  <xsl:template match="sp:literal">
    <xsl:apply-templates select="@*"/>
    <xsl:value-of select="."/>
  </xsl:template>
  <xsl:template match="sp:uri">
    <xsl:value-of select="."/>
  </xsl:template>
  <xsl:template name="_94bd13ce-5dae-4ba4-af6f-1215a8e4ba57_002fclass-1742235510107-a209-3731-aa0c">
    <xsl:param name="id"/>
    <xsl:param name="no_iri" select="false()"/>
    <xsl:variable name="id_test">
      <xsl:value-of select="c:id-key($id/*)"/>
    </xsl:variable>
    <xsl:if test="not($no_iri)">
      <xsl:for-each select="$id/sp:uri">
        <ccmm:iri>
          <xsl:value-of select="."/>
        </ccmm:iri>
      </xsl:for-each>
    </xsl:if>
    <xsl:for-each-group select="//sp:result[sp:binding[@name=$subj]/*[$id_test = c:id-key(.)] and sp:binding[@name=$pred]/sp:uri/text()=&#34;http://purl.org/dc/terms/accessRights&#34;]" group-by="c:id-key(sp:binding[@name=$obj]/*[1])">
      <xsl:for-each select="current-group()[1]">
        <ccmm:access_rights>
          <xsl:call-template name="_06b19280-5dd0-4c08-84d5-1afa55aee122_002fclass-1747685414671-e5e1-7f82-b427">
            <xsl:with-param name="id">
              <xsl:copy-of select="sp:binding[@name=$obj]/*"/>
            </xsl:with-param>
          </xsl:call-template>
        </ccmm:access_rights>
      </xsl:for-each>
    </xsl:for-each-group>
    <xsl:for-each-group select="//sp:result[sp:binding[@name=$subj]/*[$id_test = c:id-key(.)] and sp:binding[@name=$pred]/sp:uri/text()=&#34;http://purl.org/dc/terms/license&#34;]" group-by="c:id-key(sp:binding[@name=$obj]/*[1])">
      <xsl:for-each select="current-group()[1]">
        <ccmm:license>
          <xsl:call-template name="_ed82ce23-1bfb-465d-9996-7f6418ce2137_002fclass-1747640270910-1022-e495-9645">
            <xsl:with-param name="id">
              <xsl:copy-of select="sp:binding[@name=$obj]/*"/>
            </xsl:with-param>
          </xsl:call-template>
        </ccmm:license>
      </xsl:for-each>
    </xsl:for-each-group>
    <xsl:for-each-group select="//sp:result[sp:binding[@name=$subj]/*[$id_test = c:id-key(.)] and sp:binding[@name=$pred]/sp:uri/text()=&#34;http://purl.org/dc/terms/description&#34;]" group-by="c:id-key(sp:binding[@name=$obj]/*[1])">
      <xsl:for-each select="current-group()[1]">
        <ccmm:description>
          <xsl:apply-templates select="sp:binding[@name=$obj]/sp:literal"/>
        </ccmm:description>
      </xsl:for-each>
    </xsl:for-each-group>
    <xsl:for-each-group select="//sp:result[sp:binding[@name=$subj]/*[$id_test = c:id-key(.)] and sp:binding[@name=$pred]/sp:uri/text()=&#34;http://www.w3.org/ns/dcat#contactPoint&#34;]" group-by="c:id-key(sp:binding[@name=$obj]/*[1])">
      <xsl:for-each select="current-group()[1]">
        <ccmm:contact_point>
          <xsl:choose>
            <xsl:when test="//sp:result[sp:binding[@name=$subj]/*[c:id-key(.) = c:id-key(current()/sp:binding[@name=$obj]/*)] and sp:binding[@name=$pred]/sp:uri/text()=$type and (sp:binding[@name=$obj]/sp:uri/text()=&#34;http://xmlns.com/foaf/0.1/Agent&#34; or sp:binding[@name=$obj]/sp:uri/text()=&#34;http://www.w3.org/ns/prov#Organization&#34;)]">
              <ccmm:organization>
                <xsl:call-template name="_4aeb1161-45da-4adc-89ad-e9f6cd40d300_002fclass-1744871355397-62d0-acf0-af09">
                  <xsl:with-param name="id">
                    <xsl:copy-of select="sp:binding[@name=$obj]/*"/>
                  </xsl:with-param>
                </xsl:call-template>
              </ccmm:organization>
            </xsl:when>
            <xsl:when test="//sp:result[sp:binding[@name=$subj]/*[c:id-key(.) = c:id-key(current()/sp:binding[@name=$obj]/*)] and sp:binding[@name=$pred]/sp:uri/text()=$type and sp:binding[@name=$obj]/sp:uri/text()=&#34;http://www.w3.org/ns/prov#Person&#34;]">
              <ccmm:person>
                <xsl:call-template name="_bb519790-b579-4722-afc1-93e0f382a3ed_002fclass-1762017242451-3954-d430-aa66">
                  <xsl:with-param name="id">
                    <xsl:copy-of select="sp:binding[@name=$obj]/*"/>
                  </xsl:with-param>
                </xsl:call-template>
              </ccmm:person>
            </xsl:when>
          </xsl:choose>
        </ccmm:contact_point>
      </xsl:for-each>
    </xsl:for-each-group>
  </xsl:template>
  <xsl:template match="@*|*"/>
</xsl:stylesheet>
