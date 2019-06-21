//
//  LinkedList.c
//  LinkedList
//
//  Created by Artem Lytkin on 21/06/2019.
//  Copyright © 2019 Artem Lytkin. All rights reserved.
//

#include "LinkedList.h"

node createNode(int value){
    node temp;
    temp = (node)malloc(sizeof(struct LinkedList));
    temp->data = value;
    temp->next = NULL;
    return temp;
};

node addNode(node head, int value) {
    node temp, p;
    temp = createNode(value);
    if (head == NULL) {
        head = temp;
    }
    else {
        p = head;
        while (p->next != NULL) {
            p = p->next;
        }
        p->next = temp;
    }
    return head;
}
