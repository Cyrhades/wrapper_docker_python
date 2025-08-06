# Simple Wrapper Docker Python

## Description
Ce wrapper permet d'exécuter un script Python dans un conteneur Docker temporaire. 
Par défaut, la version 3.11 de Python est utilisée.


## Comment executer sous Windows
Execution de base (sans argument)
> ./run.ps1 hello.py

Execution de base (avec arguments)
> ./run.ps1 test.py argument1 argument2


Execution avec Python 3.13 (sans argument)
> ./run.ps1 -version 3.13 hello.py

Execution avec Python 3.13 (avec arguments)
> ./run.ps1 -version 3.13 argument1 argument2

Possibilité d'ajouter -debug pour obtenir du détail
> ./run.ps1 -debug hello.py


## Comment executer sous UNIX (MAC / Linux)
Execution de base (sans argument)
> ./run.sh hello.py

Execution de base (avec arguments)
> ./run.sh test.py argument1 argument2

Execution avec Python 3.13 (sans argument)
> ./run.sh -version 3.13 hello.py

Execution avec Python 3.13 (avec arguments)
> ./run.sh -version 3.13 argument1 argument2

Possibilité d'ajouter -debug pour obtenir du détail
> ./run.sh -debug hello.py



## Prérequis

- [Docker](https://www.docker.com/) doit être installé et accessible via la ligne de commande.