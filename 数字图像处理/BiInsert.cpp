#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

bool isValid(int height_src, int width_src, int x, int y)
{
    return x >= 0 && y >= 0 && x < height_src && y < width_src;
}

int bilinearInterpolate(const vector<vector<int>> &src, double x, double y, int height_src, int width_src)
{
    int x1 = floor(x);
    int y1 = floor(y);
    int x2 = x1 + 1;
    int y2 = y1 + 1;

    int Q11 = isValid(height_src,width_src,y1,x1)?src[y1][x1]:0;
    int Q12 = isValid(height_src,width_src,y2,x1)?src[y2][x1]:0;
    int Q21 = isValid(height_src,width_src,y1,x2)?src[y1][x2]:0;
    int Q22 = isValid(height_src,width_src,y2,x2)?src[y2][x2]:0;

    double dx1 = x - x1;
    double dy1 = y - y1;
    double dx2 = 1.0 - dx1;
    double dy2 = 1.0 - dy1;

    double value = Q11 * dx2 * dy2 + Q21 * dx1 * dy2 + Q12 * dx2 * dy1 + Q22 * dx1 * dy1;

    return round(value);
}

int main()
{
    int height_src, width_src, height_dst, width_dst;
    cin >> height_src >> width_src >> height_dst >> width_dst;

    vector<vector<int>> src(height_src, vector<int>(width_src));
    for (int i = 0; i < height_src; ++i)
    {
        for (int j = 0; j < width_src; ++j)
        {
            cin >> src[i][j];
        }
    }

    vector<vector<int>> dst(height_dst, vector<int>(width_dst));

    double scale_x = (double)width_src / width_dst;
    double scale_y = (double)height_src / height_dst;

    for (int i = 0; i < height_dst; ++i)
    {
        for (int j = 0; j < width_dst; ++j)
        {
            double src_x = (j + 0.5) * scale_x - 0.5;
            double src_y = (i + 0.5) * scale_y - 0.5;
            // SrcX=(dstX+0.5)* (srcWidth/dstWidth) - 0.5
            // SrcY=(dstY+0.5) * (srcHeight/dstHeight) - 0.5
            dst[i][j] = bilinearInterpolate(src, src_x, src_y, height_src, width_src);
        }
    }

    for (int i = 0; i < height_dst; ++i)
    {
        for (int j = 0; j < width_dst; ++j)
        {
            cout << dst[i][j];
            if (j != width_dst - 1)
                cout << " ";
        }
        cout << endl;
    }

    return 0;
}
