# docker-things

## Install

Add the following to your ~/.bash_profile for easy use

```bash
git clone https://github.com/t04glovern/docker-things ~/.docker-things
```

```bash
export PATH="$HOME/.docker-things:$PATH";
```

Source in the changes

```bash
source ~/.bash_profile
```

## Usage

```bash
# example up
conan-artifactory-up.sh
source $HOME/.docker-things/conan-artifactory/venv/bin/activate

# example down
conan-artifactory-down.sh
```
