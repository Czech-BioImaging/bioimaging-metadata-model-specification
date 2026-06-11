#!/usr/bin/env python3
"""
Remove all CCMM (ccmm.cz) content from index.html in three steps:
  1. Class profile sections
  2. "Data structure specification for" sections
  3. Attachments table rows
Keeps only the bioimaging-specific (non-ccmm.cz) classes.
"""
import re
import shutil

src = 'index.html'

shutil.copy2(src, src + '.bak')
print("Backup created.")

ccmm_classes = {
    'AccessRights','Address','Agent','AlternateTitle','AlternateTitleType',
    'ApplicationProfile','Checksum','ChecksumAlgorithm','ContactDetails',
    'DataService','Dataset','DateType','Description','DescriptionType',
    'Distribution','Distribution-DataService','Documentation','File',
    'Format','FundingReference','Geometry','Identifier','IdentifierScheme',
    'LanguageSystem','LicenseDocument','Location','LocationRelationType',
    'MediaType','MetadataRecord','Organization','Person',
    'ProvenanceStatement','RelatedResource','Repository','Resource',
    'ResourceAgentRoleType','ResourceRelationType','ResourceToAgentRelationship',
    'ResourceType','Subject','SubjectScheme','TermsOfUse','TimeInstant',
    'TimeInterval','TimeReference','TimeRepresentation','ValidationResult'
}

# Top-level class section patterns (10-space indent within Class profiles wrapper)
re_first = re.compile(r'^          <section id="([^"]+)">$')
re_trans  = re.compile(r'^          </section>          <section id="([^"]+)">$')
re_last   = re.compile(r'^          </section>      </section>$')

with open(src, 'r', encoding='utf-8') as f:
    lines = f.readlines()

h2_idx = next(i for i, l in enumerate(lines) if '<h2>Class profiles</h2>' in l)
print(f"Class profiles h2 at line {h2_idx + 1}")

out = list(lines[:h2_idx + 1])

current_class = None
skip = False
i = h2_idx + 1

while i < len(lines):
    line = lines[i]
    s = line.rstrip('\n')

    # Last line: closes final class + Class profiles wrapper
    if re_last.match(s):
        if not skip:
            out.append(line)
        else:
            out.append('      </section>\n')
        i += 1
        out.extend(lines[i:])
        break

    # Transition: close previous class, open next
    m = re_trans.match(s)
    if m:
        next_class = m.group(1)
        next_skip  = next_class in ccmm_classes
        if   not skip and not next_skip:
            out.append(line)
        elif not skip and next_skip:
            out.append('          </section>\n')
        elif skip and not next_skip:
            out.append(f'          <section id="{next_class}">\n')
        # skip and next_skip: output nothing
        current_class = next_class
        skip = next_skip
        i += 1
        continue

    # First class section (no preceding </section> on the same line)
    m = re_first.match(s)
    if m and current_class is None:
        current_class = m.group(1)
        skip = current_class in ccmm_classes
        if not skip:
            out.append(line)
        i += 1
        continue

    # Regular line
    if not skip:
        out.append(line)
    i += 1

with open(src, 'w', encoding='utf-8') as f:
    f.writelines(out)

print(f"Step 1 done. {len(out)} lines (was {len(lines)} lines).")

# ── Step 2: remove "Data structure specification for" sections for ccmm classes ──

ccmm_ds = {
    'Application profile', 'Media Type', 'File', 'Validation result',
    'Subject scheme', 'Address', 'Provenance Statement', 'Subject',
    'Metadata Record', 'Repository', 'Agent', 'Dataset', 'Identifier',
    'Alternate title', 'Geometry', 'Documentation', 'Data service',
    'Checksum', 'Organization', 'License Document', 'Date type',
    'Distribution', 'Resource relation type', 'Resource type',
    'Location relation type', 'Format', 'Alternate title type',
    'Access rights', 'Language system', 'Identifier scheme',
    'Time instant', 'Time interval', 'Contact details',
    'Checksum algorithm', 'Description type', 'Description',
    'Distribution - data service', 'Person',
    'Distribution - downloadable file', 'Time representation',
    'Time reference', 'Related resource', 'Location',
    'Funding reference', 'Terms of use',
    'Resource to Agent Relationship', 'Resource agent role type',
}

re_ds_open = re.compile(r'^      <section>\s*$')
re_ds_h2   = re.compile(r'^      <h2>\s*$')
re_ds_for  = re.compile(r'^\s*Data structure specification for\s*$')

with open(src, 'r', encoding='utf-8') as f:
    lines2 = f.readlines()

n2 = len(lines2)
skip_lines = set()
removed = 0
i = 0

while i < n2 - 3:
    if (re_ds_open.match(lines2[i]) and
        re_ds_h2.match(lines2[i+1]) and
        re_ds_for.match(lines2[i+2])):

        class_name = lines2[i+3].strip()
        if class_name in ccmm_ds:
            depth = 0
            for j in range(i, n2):
                depth += lines2[j].count('<section') - lines2[j].count('</section>')
                if depth == 0 and j > i:
                    for k in range(i, j + 1):
                        skip_lines.add(k)
                    removed += 1
                    i = j + 1
                    break
            continue
    i += 1

out2 = [line for idx, line in enumerate(lines2) if idx not in skip_lines]

with open(src, 'w', encoding='utf-8') as f:
    f.writelines(out2)

print(f"Step 2 done: {removed} DS sections removed.")
print(f"  {len(out2)} lines (was {len(lines2)} lines).")

# ── Step 3: remove ccmm rows from the Attachments table ─────────────────────

ccmm_dirs = {
    'application-profile', 'media-type', 'file', 'validation-result',
    'subject-scheme', 'address', 'provenance-statement', 'subject',
    'metadata-record', 'repository', 'agent', 'dataset', 'identifier',
    'alternate-title', 'geometry', 'documentation', 'data-service',
    'checksum', 'organization', 'license-document', 'date-type',
    'distribution', 'resource-relation-type', 'resource-type',
    'location-relation-type', 'format', 'alternate-title-type',
    'access-rights', 'language-system', 'identifier-scheme',
    'time-instant', 'time-interval', 'contact-details',
    'checksum-algorithm', 'description-type', 'description',
    'distribution-data-service', 'person',
    'distribution-downloadable-file', 'time-representation',
    'time-reference', 'related-resource', 'location',
    'funding-reference', 'terms-of-use',
    'resource-to-agent-relationship', 'resource-agent-role-type',
}

re_dir = re.compile(r'href="\.\./([^/]+)/')

def is_ccmm_row(block):
    m = re_dir.search(''.join(block))
    return m and m.group(1) in ccmm_dirs

with open(src, 'r', encoding='utf-8') as f:
    lines3 = f.readlines()

tbody_starts = [i for i, l in enumerate(lines3) if '<tbody>' in l]
tbody_ends   = [i for i, l in enumerate(lines3) if '</tbody>' in l]
tbody_start  = tbody_starts[1]   # second <tbody> = Attachments table
tbody_end    = tbody_ends[1]

out3 = list(lines3[:tbody_start + 1])
i = tbody_start + 1
removed = 0

while i < tbody_end:
    stripped = lines3[i].strip()
    if stripped == '<tr>':
        block = []
        while i < tbody_end:
            block.append(lines3[i])
            if '</tr>' in lines3[i]:
                i += 1
                break
            i += 1
        if is_ccmm_row(block):
            removed += 1
        else:
            out3.extend(block)
    elif stripped.startswith('<tr>'):
        if is_ccmm_row([lines3[i]]):
            removed += 1
        else:
            out3.append(lines3[i])
        i += 1
    else:
        out3.append(lines3[i])
        i += 1

out3.extend(lines3[tbody_end:])

with open(src, 'w', encoding='utf-8') as f:
    f.writelines(out3)

print(f"Step 3 done: {removed} attachment rows removed.")
print(f"Final: {len(out3)} lines written (was {len(lines3)} lines).")
