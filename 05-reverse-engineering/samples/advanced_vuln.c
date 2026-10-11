#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Hidden function - goal: find and call it
void secret_function() {
    printf("\n🎉 Congratulations! You found the secret function!\n");
    printf("Flag: FLAG{buffer_overflow_master_2025}\n");
    system("/bin/sh");
}

void vulnerable_function(char *input) {
    char buffer[64];
    strcpy(buffer, input);
    printf("You entered: %s\n", buffer);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <input>\n", argv[0]);
        return 1;
    }
    
    printf("=== Advanced Vulnerable Binary ===\n");
    vulnerable_function(argv[1]);
    printf("Goodbye!\n");
    return 0;
}
