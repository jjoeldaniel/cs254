#!/usr/bin/env bash

DB_PATH="phonebook.txt"
TMP_PATH="phonebook_tmp.txt"

if [[ "${#}" = 0 ]]; then
  echo "Usage: "${0}" <command> [args]"
  echo ""
  echo "Commands:"
  echo ""
  echo ""${0}" new <name> <number>"
  echo ""
  echo ""${0}" <name>"
  echo "Get the phone number of a contact"
  echo ""
  echo ""${0}" list"
  echo "List all contacts in the phonebook"
  echo ""
  echo ""${0}" remove <name>"
  echo "Remove a contact from the phonebook"
  echo ""
  echo ""${0}" clear"
  echo "Remove all contacts from the phonebook"
  echo ""
  exit 1
fi

if [[ "${1}" = "list" ]]; then
  if [[ -e "${DB_PATH}" ]]; then
    cat "${DB_PATH}" 2>/dev/null
  else
    echo "phonebook is empty"
  fi
elif test -f ${DB_PATH} && grep -q "\b${1}\b" "${DB_PATH}" ; then
  LINE=$(echo $(grep -n "\b${1}\b" "${DB_PATH}") | cut -d: -f1)
  sed "${LINE}q;d" ${DB_PATH}
elif [[ "${1}" = "new" ]]; then
  touch ${DB_PATH} 2> /dev/null
  echo "${2} ${3}" >> "${DB_PATH}"
elif [[ "${1}" = "clear" ]]; then
  rm -f "${DB_PATH}"
elif [[ "${1}" = "remove" ]]; then
  LINE=$(grep -n "^$2" "${DB_PATH}" | cut -d: -f1)
  sed "${LINE}d" "${DB_PATH}" >>"${TMP_PATH}"
  mv "${TMP_PATH}" "${DB_PATH}"
fi
