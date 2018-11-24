#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <vector>
#include <sstream>

using namespace std;

void spiltStringBySpace(string* str, vector<string>* vec);

int main( int argc, char** argv ) {

    if(argc < 2) {
        std::cerr << "Error, please execute with arg: ." << argv[0] << " <input_file>" << endl;
    }

    ifstream inputFile( argv[1] , ios::in ); // получаем файл с расширением .ged
    if (!inputFile) {
        std::cerr << "File could not to be open" << endl;
        exit(1);
    }

    ofstream outputFile;
    if(argc == 3) {
        outputFile.open( argv[2], ios::out );
    }
    else {
        outputFile.open( "gen_tree.pl", ios::out );
    }


    string id ,name, surname;
    string wife, husband;
    map<string, string> tree; // tree[id] = person



    for (string currentLine; getline(inputFile ,currentLine); ) { // пробегаем по каждой строке
        id = name = surname = "";
        vector<string> currentLineSplit;
        spiltStringBySpace(&currentLine, &currentLineSplit); // разбиваем строку на слова

        if (currentLineSplit.size() < 3) { // чтобы избежать ошибки доступа по индексу [2]
            continue;
        }



        if (currentLineSplit[2] == "INDI") { // Начало парсинга члена семьи
            id = currentLineSplit[1];
            while ( currentLineSplit[1] != "GIVN" && currentLineSplit[1] != "_MARNM" ) {
                getline(inputFile ,currentLine);
                spiltStringBySpace(&currentLine, &currentLineSplit);
            }
            name = currentLineSplit[2];

            while ( currentLineSplit[1] != "SURN" ) {
                getline(inputFile ,currentLine);
                spiltStringBySpace(&currentLine, &currentLineSplit);
            }
            surname = currentLineSplit[2];


            tree[id] = surname + " " + name;

        }
        else if (currentLineSplit[2] == "FAM") { // Начало парсинга семьи
            wife = "";
            husband = "";
            getline(inputFile ,currentLine);
            getline(inputFile ,currentLine);
            spiltStringBySpace(&currentLine, &currentLineSplit);
            // Проверка на случай, если неизвестен один из членов семьи
            auto it = tree.find(currentLineSplit[2]);
            if (currentLineSplit[1] == "HUSB" && it != tree.end() ) {
                husband = tree[currentLineSplit[2]];
                getline(inputFile ,currentLine);
                spiltStringBySpace(&currentLine, &currentLineSplit);
            }

            it = tree.find(currentLineSplit[2]);
            if (currentLineSplit[1] == "WIFE" && it != tree.end()) {
                wife = tree[currentLineSplit[2]];
                getline(inputFile ,currentLine);
                spiltStringBySpace(&currentLine, &currentLineSplit);
            }

            while ( currentLineSplit[1] == "CHIL" ) {
                it = tree.find(currentLineSplit[2]);
                if ( husband != "" && wife != "" && it != tree.end()){
                    outputFile << "parents(\"" << tree[currentLineSplit[2]] <<"\",\"" << husband<<"\",\""<< wife<<"\")."<<endl;
                }
                getline(inputFile ,currentLine);
                spiltStringBySpace(&currentLine, &currentLineSplit);
            }

        }
    }



    return 0;
}

void spiltStringBySpace(string* str, vector<string>* vec) {
    vec->clear();
    istringstream iss(*str);
    for(string s; iss >> s; ) {
        vec->push_back(s);
    }
}