#!/bin/bash

#Author: Ranabir Chakraborty
#Description: Check the possible Replacement Java EE References from the i18n strings. Those strings are in the various XXXLogger.java files and the LocalDescriptions.properties files.

#/   --help: Display this help message
usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

readonly LOG_FILE="/tmp/$(basename "$0").log"
info()    { echo "[INFO]    $*" | tee -a "$LOG_FILE" >&2 ; }
warning() { echo "[WARNING] $*" | tee -a "$LOG_FILE" >&2 ; }
error()   { echo "[ERROR]   $*" | tee -a "$LOG_FILE" >&2 ; }
fatal()   { echo "[FATAL]   $*" | tee -a "$LOG_FILE" >&2 ; exit 1 ; }


if [[ "${BASH_SOURCE[0]}" = "$0" ]]; then

#Uncomment the below JavaEE specifications to search 

    declare -a StringArray=(\
        #"Java Servlet" \
        #"JavaServer Faces|JSF" \
        #"Java API for WebSocket" \
        #"Concurrency Utilities for Java EE" \
        #"Interceptors" \ 
        #"Java Authentication Service Provider Interface for Containers|JASPIC" \
        #"Java Authorization Contract for Containers|JACC" \
        #None "Java EE Security API" \
        #"Java Message Service|JMS" \
        #"Java Persistence API|JPA" \
        #"Java Transaction API|JTA" \
        #"Batch Applications for the Java Platform|JBatch" \
        #"JavaMail" \
        #"Java EE Connector Architecture|JCA" \
        #"Common Annotations for Java Platform" \
        #"JavaBeans Activation Framework|JAF" \
        #"Bean Validation|JBV" \
        #"Expression Language|JEL" \
        #"Enterprise JavaBeans|EJB" \
        #"Java Architecture for XML Binding|JAXB" \
        #"Java API for JSON Binding|JSON-B" \
        #"JavaServer Pages|JSP" \
        #"Java API for XML-Based Web Services|JAX-WS" \
        #"Java API for RESTful Web Services|JAX-RS" \
        #"JavaServer Pages Standard Tag Library|JSTL" \
        #"Contexts and Dependency Injections|CDI" \
        #"Java API for JSON Processing|JSON-P" \
        #"Java API for XML-Based RPC|JAX-RPC" \
        #"Java API for XML Registries|JAXR"\
        )

    # Iterate the string array using for loop
    
    for val in "${StringArray[@]}"; do
       info "----------------------------------------------------------------------------------------------> ${val}"

       #grep -E -r --ignore-case -n "${val}" | grep --ignore-case "logger" | grep -v "private static final" | grep -v "import static "
       #grep -E -r --ignore-case -n "${val}" | grep --ignore-case ".properties" | grep -v "private static final" | grep -v "import static "

       grep -E -r --ignore-case -n "${val}" | grep --ignore-case "Logger.java"
       grep -E -r --ignore-case -n "${val}" | grep --ignore-case "LocalDescriptions.properties"
    done

fi
