#!/bin/bash

# Valeurs par défaut
version="3.11"
debug=false
script_args=()

# Fonction d'affichage conditionnel pour debug
debug_echo() {
    if [ "$debug" = true ]; then
        echo "$1"
    fi
}

# Parsing des arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -debug)
            debug=true
            shift
            ;;
        -version=*|--version=*)
            version="${1#*=}"
            shift
            ;;
        -version|--version)
            if [[ -n "$2" ]]; then
                version="$2"
                shift 2
            else
                echo "Erreur : -version attend une valeur." >&2
                exit 1
            fi
            ;;
        *)
            script_args+=("$1")
            shift
            ;;
    esac
done

# Vérifier qu'un script est bien fourni
if [ ${#script_args[@]} -lt 1 ]; then
    echo "Erreur : veuillez fournir un fichier script Python à exécuter." >&2
    exit 1
fi

script_path="${script_args[0]}"
script_params=("${script_args[@]:1}")

# Vérifier si le fichier existe tel quel ou dans ./app/
if [ ! -f "$script_path" ]; then
    if [ -f "./app/$script_path" ]; then
        script_path="./app/$script_path"
    else
        echo "Erreur : le fichier '$script_path' est introuvable." >&2
        exit 1
    fi
fi

# Obtenir le chemin absolu du dossier ./app
app_path="$(pwd)/app"
image_name="python:${version}-slim"

debug_echo "Version Python demandée : $version"
debug_echo "Exécution de $script_path avec arguments : ${script_params[*]}"

# Exécution avec Docker
docker run --rm -it \
    -v "$app_path:/app" \
    -w /app \
    "$image_name" \
    python "$script_path" "${script_params[@]}"
