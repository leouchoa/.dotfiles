# Neovim Config

## Asd

## Configuring `pyenv` and `pyright`

To integrate all of `pyright`'s lsp capabilities, you have to create a `pyrightconfig.json` file with the following content:

```python
{
   "venv" : "python_virtualenv_name",
   "venvPath" : "/path/to/.pyenv/versions"
   # "venvPath" : "/Users/mac_user_name/.pyenv/versions" # for mac
}

```

Alternatively you can use the [`pyenv-pyright`](https://github.com/alefpereira/pyenv-pyright) plugin. Here's the TLDR install process for mac:

1. `git clone https://github.com/alefpereira/pyenv-pyright.git $(pyenv root)/plugins/pyenv-pyright`
2. activate the env by running `pyenv local venv_name`
3. run `pyenv pyright`

**Pay attention to this error**: if you're using `conda`-enabled envs, they will probably look like this: `minicondaVERSION-tag/envs/conda_created_venv`. In this case running `pyenv pyright` won't work as the plugin won't be able to local the environment.
In this case simply create the `pyrightconfig.json` file by hand and add the `minicondaVERSION-tag/envs/conda_created_venv` in the `"venv"` entry.
