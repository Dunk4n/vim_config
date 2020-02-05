# Vim_config
my vim config with templates

## Installation
add this to your .vimrc
```
source ~/.vim/vim_config/.vimrc
```

and clone the repo in your .vim

#### I was inspired by this github ([vim-templates](https://github.com/tibabit/vim-templates))

## Placeholders

The Following placeholders are currently supported

### File name

- `FILE` : Basename of the file `filename.ext -> filename`
- `FILEE` : Filename with extension `filename.ext -> filename.ext`
- `FILEF` : Absolute path of the file `/path/to/directory/filename.ext`
- `FILER` : Filepath relative to the current directory (pwd)`/relative/to/filename.ext`

### Others

- `MACRO_GUARD` : Macro guard for use in c/c++ files. `filename.h -> FILENAME_H`. All dots(.) and dashes (-) present in filename are converted into underscores (_).
- `MACRO_GUARD_FULL` : Same as `MACRO_GUARD`, except relative path is used in place of file name. e.g. `relative/to/filename.h -> RELATIVE_TO_FILENAME_H`
- `CLASS` : class name, same as `FILE`
- `CURSOR` : This is a spacial placeholder, it does not expand into anything but the cursor is placed at this location after the template expansion
- `HEADER` : use function stored in g:FunctionForHeader, you can use 42 or EPITECH header with Insert42Header and AddTekHeader

AddTekHeader was originally created by [x4m3](https://github.com/x4m3)

Insert42Header was originally created by 42

### Use Placeholders

Put the placeholders in `{{placeholders_name}}` and for expand all placeholders use `:TemplateExpand`

check ([vim-templates](https://github.com/tibabit/vim-templates)) for more details

## Snippet

The Following snippets are currently supported

- `IF` : just an if
- `IFE` : if and else
- `IFEL` : if, else if
- `IFELE` : if, else if and else
- `for` : just a for
- `while` : just a while
- `MAIN` : main with argc and argv
- `MAINE` : main with argc, argv and env
- `COUT` : std::cout <<  << std::endl;
