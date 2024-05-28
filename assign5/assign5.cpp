#include <iostream>
#include <vector>
using namespace std;


struct cacheLine 
{
    int startAddress;
    int cacheAge;
};

struct cacheMemory 
{
    int lineSize;
    int numLines;
    int accessTime;
    vector<cacheLine> cacheLines;
};



void initializeCache(cacheMemory& cacheMemory, int lineSize, int numLines, int accessTime);
void accessingMemory(int cacheAddresses, int& cycles);
bool accessingCache(cacheMemory& cacheMemory, int cacheAddresses, int& cycles);
void reformCache(cacheMemory& cacheMemory, int cacheAddresses);
int cacheSimulate(const vector<int>& cacheAddresses) ;

int main() 
{
    vector<int> cacheAddresses = {0x1000, 0x1024, 0x1599, 0x100, 0x10245, 0x10246, 0x1027, 0x10247, 0x1600, 0x1601, 0x1700};
    int totalCycles = cacheSimulate(cacheAddresses);
    cout << totalCycles << endl;
    
    return 0;
}

void initializeCache(cacheMemory& cacheMemory, int lineSize, int numLines, int accessTime) 
{
    cacheMemory.lineSize = lineSize;
    cacheMemory.numLines = numLines;
    cacheMemory.accessTime = accessTime;
    cacheMemory.cacheLines.resize(numLines, {-1, -1});
}

bool accessingCache(cacheMemory& cacheMemory, int cacheAddresses, int& cycles) 
{
    cycles += cacheMemory.accessTime;
    int baseAddress = (cacheAddresses / cacheMemory.lineSize) * cacheMemory.lineSize;
    for (auto& line : cacheMemory.cacheLines) {
        if (line.startAddress == baseAddress) {
            line.cacheAge = 0;
            for (auto& l : cacheMemory.cacheLines) {
                if (&l != &line) {
                    l.cacheAge++;
                }
            }
            
            return true; 
        }
    }
    
    return false;
}

void reformCache(cacheMemory& cacheMemory, int cacheAddresses) 
{
    int baseAddress = (cacheAddresses / cacheMemory.lineSize) * cacheMemory.lineSize;
    int oldestLineIndex = 0;
    int maxAge = -1;
    
    for (int i = 0; i < cacheMemory.numLines; ++i) 
    {
        if (cacheMemory.cacheLines[i].cacheAge > maxAge) 
        {
            maxAge = cacheMemory.cacheLines[i].cacheAge;
            oldestLineIndex = i;
        }
    }
    
    cacheMemory.cacheLines[oldestLineIndex] = {baseAddress, 0};
    
    for (int i = 0; i < cacheMemory.numLines; ++i) 
    {
        if (i != oldestLineIndex) 
        {
            cacheMemory.cacheLines[i].cacheAge++;
        }
    }
}

void accessingMemory(int cacheAddresses, int& cycles) 
{
    cycles += 1000;
}

int cacheSimulate(const vector<int>& cacheAddresses) 
{
    int cycles = 0;
    cacheMemory L1, L2, L3;

    initializeCache(L1, 256, 4, 1);
    initializeCache(L2, 1024, 64, 10);
    initializeCache(L3, 4096, 256, 100);

    for (auto cacheAddresses : cacheAddresses) {
        if (!accessingCache(L1, cacheAddresses, cycles)) 
        {
            if (!accessingCache(L2, cacheAddresses, cycles)) 
            {
                if (!accessingCache(L3, cacheAddresses, cycles)) 
                {
                    accessingMemory(cacheAddresses, cycles);
                    reformCache(L3, cacheAddresses);
                }
                reformCache(L2, cacheAddresses);
            }
            reformCache(L1, cacheAddresses);
        }
    }
    
    return cycles;
}
