#!/bin/bash

#  SPDX-License-Identifier: MIT-0 OR CC0-1.0  #
#     Authored 2024 by Peter S. Hollander     #




# 1.0.3

# Pre-commit git hook for committing reduced, usable, & trackable .FCStd files
# ----------------------------------------------------------------------------

#   This was made primarily with parametric PartDesign workflows in mind.

#   Recomputing from reduced .FCStd files appears to non-deterministically
#   regenerate their structure, essentially costing a commit the size of the
#   entire file if you commit after a checkout/clone.

#   Continuously committing from the same non-reduced local source document
#   does not encounter this issue.




# Single-colour file exclusion:
#   Uncomment if you want to exclude (hopefully) recomputable colour files

ExcludeSingleColourFiles=true


# Total file exclusion:
#   Only uncomment file types you're 100% confident you don't need tracked!
#   For large files, you may be forced to exclude most file types, as
#   `git archive` will approach an argument list limit during .FCStd repacking.

ExcludeFiles="" # Always leave this uncommented

ExcludeFiles+=" *.brp"
ExcludeFiles+=" PointColorArray*"
ExcludeFiles+=" LineColorArray*"
#ExcludeFiles+=" DiffuseColor*"
ExcludeFiles+=" ScaleList*"
ExcludeFiles+=" PlacementList*"




# --show-toplevel should throw an error if there is no working tree (untested)
GitRoot=$(git rev-parse --show-toplevel)

# Get an array of the paths of each staged file
StagedFiles=($(git diff --cached --name-only))


FCStdErrorCount=0
for file in "${StagedFiles[@]}"; do
  # For every .FCStd staged for commit:
  if [[ "${file^^}" == *\.FCSTD ]]; then
    #echo "Identified staged" $file


    if [[ ! `git rev-parse --verify HEAD 2>&-` ]]; then
      echo "FCStd pre-commit hook cannot find HEAD! Unstage .FCStd before making an initial commit."
      (( FCStdErrorCount+=1 )); continue
    fi


    if [[ ! -s "${GitRoot}"/"${file}" ]]; then
      echo $file "does not exist - assuming this is a deletion commit."
      continue # No fixup necessary
    fi


    #echo "Saving temporary copy of unmodified .FCStd"
    mv "${GitRoot}"/"${file}" "${GitRoot}"/"${file}".bak


    if [[ ! -s "${GitRoot}"/"${file}".bak ]]; then
      echo "Unable to move" $file "Is it open somewhere other than FreeCAD?"
      (( FCStdErrorCount+=1 )); continue
    fi


    #echo "Extracting selected .FCStd source files..."
    mkdir "${GitRoot}"/.unzip-temp/
    unzip -q "${GitRoot}"/"${file}".bak -x $ExcludeFiles -d "${GitRoot}"/.unzip-temp/incoming/ 2>&-


    if [[ ! -d "${GitRoot}"/.unzip-temp/incoming || ! -s "${GitRoot}"/.unzip-temp/incoming/Document.xml ]]; then
      echo "Unable to find extracted .FCStd - aborting"
      rm -r "${GitRoot}"/.unzip-temp/
      mv --force "${GitRoot}"/"${file}".bak "${GitRoot}"/"${file}"
      (( FCStdErrorCount+=1 )); continue
    fi


    # Delete recomputable (ie. 8 bytes / 1 colour) colour files if requested
    if [[ "$ExcludeSingleColourFiles" = true ]] ; then
      find "${GitRoot}"/.unzip-temp/incoming/ -name "*Color*" -size -9c -delete
    fi

    #echo "Marking all .FCStd objects for recompute..."
    sed --regexp-extended \
        --expression='s|(Object.*type=.*")[ ]*Touched="1"[ ]*/>|\1 />|' \
        --expression='s|(Object.*type=.*")[ ]*/>|\1 Touched="1" />|' \
        --expression='s|(_Property.*name="_Body.*status=".*)0"[ ]*/>|\11"/>|' \
        --expression='s|(_Property.*name="_Body.*status=".*)2"[ ]*/>|\13"/>|' \
        --expression='s|(_Property.*name="_Body.*status=".*)4"[ ]*/>|\15"/>|' \
        --expression='s|(_Property.*name="_Body.*status=".*)6"[ ]*/>|\17"/>|' \
        --expression='s|(_Property.*name="_Body.*status=".*)8"[ ]*/>|\19"/>|' \
        --in-place "${GitRoot}"/.unzip-temp/incoming/Document.xml


    if [[ ! `git cat-file -e HEAD:"${file}" 2>&1` ]]; then
      # $file exists in HEAD
      #echo "Comparing with previous version..."
      git checkout HEAD -- "${file}"
      unzip -q "${GitRoot}"/"${file}" -d "${GitRoot}"/.unzip-temp/previous/ 2>&-
      rm "${GitRoot}"/"${file}"

      if [[ ! `diff -N --recursive "${GitRoot}"/.unzip-temp/previous/ "${GitRoot}"/.unzip-temp/incoming/` ]]; then
        #echo $file "archive contents are identical; not staging"
        rm -r "${GitRoot}"/.unzip-temp/
        mv --force "${GitRoot}"/"${file}".bak "${GitRoot}"/"${file}"
        continue
      fi
    fi


    #echo "Differences found in archive contents - Repackaging uncompressed .FCStd"
    #   Create an array of all non-xml files and prepend the command `--add-file=.unzip-temp/incoming/`
    AppendCommandList=$(ls --ignore "*.xml" "${GitRoot}"/.unzip-temp/incoming/ | sed 's/^/--add-file=.unzip-temp\/incoming\//')
    #   Make a temporary commit so we can leverage `git archive`
    git add .unzip-temp/incoming/
    git commit --quiet --no-verify -m "Temp commit by pre-commit hook for .FCStd tracking" -- .unzip-temp/incoming/
    #   Zip the extracted files back up, but with 0 compression
    #   XMLs will be at the top of the archive, followed by alphabetical contents in $AppendCommandList
    git archive --format=zip -0 $AppendCommandList --output="${file}" -- HEAD:.unzip-temp/incoming/ "*.xml"

    #echo "Cleaning up"
    git reset --soft HEAD~
    git reset --quiet .unzip-temp/
    rm -r "${GitRoot}"/.unzip-temp/


    if [[ ! -s "${GitRoot}"/"${file}" ]]; then
      echo "Error recreating archive - aborting"
      mv --force "${GitRoot}"/"${file}".bak "${GitRoot}"/"${file}"
      (( FCStdErrorCount+=1 )); continue
    fi


    #echo "Staging uncompressed .FCStd for commit"
    git add "${file}"

    #echo "Restoring unmodified .FCStd"
    if [[ `mv --force "${GitRoot}"/"${file}".bak "${GitRoot}"/"${file}"` ]]; then
      echo $file "unable to be restored! Resave FreeCAD if it is open, or manually rename *.FCStd.bak to replace *.FCStd to restore the local file, then try again"
      # TODO - Probably busy from FreeCAD autosaving; any workaround?
      (( FCStdErrorCount+=1 )); continue
    fi

    echo $file "reduced, repacked, and staged for commit."

  fi

done




if (( FCStdErrorCount > 0 )); then
  echo ".FCStd pre-commit hook encountered" "${FCStdErrorCount}" "error(s); aborting commit"
  exit 1
fi


if [[ `git rev-parse --verify HEAD 2>&-` ]]; then
  # HEAD exists
  if [[ ! `git diff-index --cached HEAD` ]]; then
    echo "No changes to commit."
    exit 1
  fi
fi


exit 0
