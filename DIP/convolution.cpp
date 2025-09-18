#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

vector<vector<int>> convolve(const vector<vector<int>>& src, const vector<vector<float>>& kernel) {
    int m = src.size(); 
    int n = src[0].size(); 
    int u = kernel.size(); 
    int v = kernel[0].size(); 

    vector<vector<int>> result(m, vector<int>(n, 0));

    int u_radius = u / 2;
    int v_radius = v / 2;

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            float sum = 0.0;
            for (int ki = -u_radius; ki <= u_radius; ++ki) {
                for (int kj = -v_radius; kj <= v_radius; ++kj) {
                    int ni = i + ki;
                    int nj = j + kj;

                    if (ni >= 0 && ni < m && nj >= 0 && nj < n) {
                        sum += src[ni][nj] * kernel[ki + u_radius][kj + v_radius];
                    }
                }
            }

            result[i][j] = round(sum);
        }
    }

    return result;
}

void printMatrix(const vector<vector<int>>& matrix) {
    int rows = matrix.size();
    int cols = matrix[0].size();

    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            cout << matrix[i][j];
            cout << " ";
        }
        cout << endl;
    }
}

int main() {
    int m, n, u, v;

    cin >> m >> n;

    cin >> u >> v;

    vector<vector<int>> src(m, vector<int>(n));
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            cin >> src[i][j];
        }
    }

    vector<vector<float>> kernel(u, vector<float>(v));
    for (int i = 0; i < u; ++i) {
        for (int j = 0; j < v; ++j) {
            cin >> kernel[i][j];
        }
    }

    vector<vector<int>> result = convolve(src, kernel);

    printMatrix(result);

    return 0;
}
