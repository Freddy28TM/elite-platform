#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
    char input[512];
    
    printf("=== Advanced Vulnerable Binary (stdin) ===\n");
    printf("Enter input: ");
    fflush(stdout);
    
    if (fgets(input, sizeof(input), stdin) == NULL) {
        return 1;
    }
    
    // Remove newline
    input[strcspn(input, "\n")] = 0;
    
    vulnerable_function(input);
    printf("Goodbye!\n");
    return 0;
}
