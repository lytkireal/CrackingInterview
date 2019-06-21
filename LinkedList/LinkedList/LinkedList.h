//
//  LinkedList.h
//  LinkedList
//
//  Created by Artem Lytkin on 21/06/2019.
//  Copyright © 2019 Artem Lytkin. All rights reserved.
//

#ifndef LinkedList_h
#define LinkedList_h

#include <stdio.h>
#include <stdlib.h>

typedef struct LinkedList *node;

struct LinkedList{
    int data;
    struct LinkedList *next;
};

node createNode(int value);
node addNode(node head, int value);

#endif /* LinkedList_h */


