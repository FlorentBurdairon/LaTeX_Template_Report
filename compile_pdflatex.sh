#!/bin/bash
function compile_biblio() {
    read -p "Compile biblio? [y/n(default)] : " user_input         # lit la reponse de l'utilisateur
    if [ "$user_input" == "y" ]; then
        echo "Compile biblio with biber"
        biber -output-directory $output_directory_relative_path $src_main_file
        echo "Compile pdflatex a 2nd time after biber"
        pdflatex -output-directory $output_directory_relative_path $src_main_file
    fi
}
function open_pdf() {
    read -p "Open pdf file? [y/n(default)] : " user_input         # lit la reponse de l'utilisateur
    if [ "$user_input" == "y" ]; then
        echo "Opening pdf file"
        xdg-open $src_main_file".pdf" &
    fi
}
function remove_auxiliary_files() {
    read -p "Remove auxiliary files? [y/n(default)] : " user_input         # lit la reponse de l'utilisateur
    if [ "$user_input" == "y" ]; then
        echo "Remove auxiliary files from directory" $output_directory_path
        ls | grep -v *.pdf | xargs rm -v
    fi
}

# === change here if new project ==========================
src_directory="./latex_src/"
src_main_file="0_main" # <------------- main file name !!!!
output_directory_path="./output/"
output_directory_relative_path="../"$output_directory_path
# =========================================================

cd $src_directory # go to sources directory
pdflatex -halt-on-error -output-directory $output_directory_relative_path $src_main_file
compile_biblio
cd "../"$output_directory_path # go to output directory
remove_auxiliary_files
open_pdf
