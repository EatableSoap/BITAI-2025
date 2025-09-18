#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

const int dx4[] = {-1, 1, 0, 0};
const int dy4[] = {0, 0, -1, 1};
const int dx8[] = {-1, -1, -1, 0, 0, 1, 1, 1};
const int dy8[] = {-1, 0, 1, -1, 1, -1, 0, 1};

bool isValid(int x, int y, int w, int h) {
    return (x >= 0 && x < w && y >= 0 && y < h);
}

void bfs(const vector<vector<int>>& image, vector<vector<bool>>& visited, int start_x, int start_y, int w, int h, int k, vector<pair<int, int>>& component) {
    queue<pair<int, int>> q;
    q.push({start_x, start_y});
    visited[start_y][start_x] = true;

    while (!q.empty()) {
        int x = q.front().first;
        int y = q.front().second;
        q.pop();

        component.push_back({x, y});

        for (int d = 0; d < (k == 4 ? 4 : 8); ++d) {
            int nx = x + (k == 4 ? dx4[d] : dx8[d]);
            int ny = y + (k == 4 ? dy4[d] : dy8[d]);
            if (isValid(nx, ny, w, h) && image[ny][nx] == 1 && !visited[ny][nx]) {
                visited[ny][nx] = true;
                q.push({nx, ny});
            }
        }
    }
}

int main() {
    int w, h, k;
    cin >> w >> h >> k;
    vector<vector<int>> image(h, vector<int>(w));
    vector<vector<bool>> visited(h, vector<bool>(w, false));

    for (int i = 0; i < h; ++i) {
        for (int j = 0; j < w; ++j) {
            cin >> image[i][j];
        }
    }

    int component_count = 0;
    for (int y = 0; y < h; ++y) {
        for (int x = 0; x < w; ++x) {
            if (image[y][x] == 1 && !visited[y][x]) {
                ++component_count;
                vector<pair<int, int>> component;
                bfs(image, visited, x, y, w, h, k, component);
                
                sort(component.begin(), component.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
                    return a.second == b.second ? a.first < b.first : a.second < b.second;
                });
                
                cout << component_count << "-th component:" << endl;
                for (const auto& p : component) {
                    cout << p.first << " "<< p.second << endl;
                }
            }
        }
    }

    return 0;
}
