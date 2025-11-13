#include <iostream>
#include <vector>
#include <cmath>
#include <unordered_map>

using namespace std;

int main()
{
    unordered_map<int, int> pixelmap;
    for (int i = 0; i < 8; i++)
    {
        for (int j = 0; j < 8; j++)
        {
            int val = 0;
            cin >> val;
            if (!pixelmap.count(val))
            {
                pixelmap[val] = 1;
            }
            else
            {
                pixelmap[val]++;
            }
        }
    }

    vector<int> accumulation;

    float freq = 0.0;
    for (int i = 0; i < 8; i++)
    {
        if (!pixelmap.count(i))
            freq += 0;
        else
        {
            freq += pixelmap[i] / 64.0;
        }
        int transLevel = round(freq * 7);
        accumulation.push_back(transLevel);
    }

    for (int i = 0; i < accumulation.size(); i++)
    {
        if (i)
            cout << " ";
        cout << accumulation[i];
    }
    cout<<endl;
}