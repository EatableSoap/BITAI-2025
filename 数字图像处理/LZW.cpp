#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

vector<int> lzwEncode(const vector<int>& input) {
    unordered_map<string, int> dictionary;
    int dictSize = 256;
    for (int i = 0; i < 256; ++i) {
        dictionary[string(1, i)] = i;
    }

    string current;
    vector<int> encodedOutput;

    for (int i = 0; i < input.size(); ++i) {
        char c = input[i];
        string next = current + c;
        
        if (dictionary.find(next) != dictionary.end()) {
            current = next;
        } else {
            encodedOutput.push_back(dictionary[current]);
            
            dictionary[next] = dictSize++;
            
            current = string(1, c);
        }
    }

    if (!current.empty()) {
        encodedOutput.push_back(dictionary[current]);
    }

    return encodedOutput;
}

int main() {
    int M, N;
    cin >> M >> N;

    vector<int> src;

    for (int i = 0; i < M; ++i) {
        for (int j = 0; j < N; ++j) {
            int pixel;
            cin >> pixel;
            src.push_back(pixel);
        }
    }

    vector<int> encodedOutput = lzwEncode(src);

    for (size_t i = 0; i < encodedOutput.size(); ++i) {
        if (i > 0) cout << " ";
        cout << encodedOutput[i];
    }
    cout << endl;

    return 0;
}
