#include <iostream>
#include <bitset>
#include <fstream>

using namespace std;


void decodemipsInstructions(unsigned int mipsInstructions);
unsigned int getBITS(unsigned int number, int start, int length);

int main(){
	ifstream readFile("/usr/local/class/cs241/mips-test.bin");

	if(!readFile.is_open()){
		cout << "Error opening the file!" << endl;
		return 1;
	}

	unsigned int mipsInstructions;
	while (readFile.read(reinterpret_cast<char*>(&mipsInstructions), sizeof(mipsInstructions))){
		decodemipsInstructions(mipsInstructions);
	}

	readFile.close();
	return 0;
	
}


void decodemipsInstructions(unsigned int mipsInstructions)
 {
    unsigned int mipsOPCODE = getBITS(mipsInstructions, 26, 6);
    cout << "The Opcode:: " << bitset<6>(mipsOPCODE) << " (" << mipsOPCODE << ")" << endl;

    if (mipsOPCODE == 0) 
    { // R-type
        unsigned int RS = getBITS(mipsInstructions, 21, 5);
        unsigned int RT = getBITS(mipsInstructions, 16, 5);
        unsigned int RD = getBITS(mipsInstructions, 11, 5);
        unsigned int shamt = getBITS(mipsInstructions, 6, 5);
        unsigned int funct = getBITS(mipsInstructions, 0, 6);
        
        cout << "Instruction Format: R" << endl;
        cout << "RS register number: " << RS << endl;
        cout << "RT register number: " << RT << endl;
        cout << "RD register number: " << RD << endl;
        cout << "shamt: " << shamt << endl;
        cout << "funct: " << funct << endl;
    } 
    else if (mipsOPCODE == 2 || mipsOPCODE == 3) { 
        unsigned int jumpAddress = getBITS(mipsInstructions, 0, 26);
        
        cout << "Instruction Format: J" << endl;
        cout << "Jump Address;: " << jumpAddress << endl;
    } 
    else { 
        unsigned int RS = getBITS(mipsInstructions, 21, 5);
        unsigned int RT = getBITS(mipsInstructions, 16, 5);
        unsigned int immediateValue = getBITS(mipsInstructions, 0, 16);
        
        cout << "Instruction Format: I" << endl;
        cout << "RS register number: " << RS << endl;
        cout << "RT register number: " << RT << endl;
        cout << "Immediate Value: " << immediateValue << endl;
    }
    	cout << endl;
}


unsigned int getBITS(unsigned int num, int extract, int bitlength) {
    return (num >> extract) & ((1 << bitlength) - 1);
}
