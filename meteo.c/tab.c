#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Info {
    int e;
    char *valeur;
};

int comparer(const void *a, const void *b) {
    struct Info *info1 = (struct Info *)a;
    struct Info *info2 = (struct Info *)b;
    return info1->e - info2->e;
}
