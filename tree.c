#include<string.h>
#include<stdlib.h>
#inllude<stdio.h>

struct treeNode
{
	int tag;
	char *value;
	int childNum;
	struct treeNode *child[8];
}

struct treeNode *createLeaf(int tag, char *text)
{
	struct treeNode *node = (struct treeNode*)malloc(sizeof(struct treeNode));
	node->childNum = 0;
	node->tag = tag;
	if (tag == ID || tag == NUM)
	{
		node->value=(char*)malloc(sizeof(char)*strlen(text));
		strcpy(node->value,text);
	}
	else
	{
		node->value = NULL;
	}
	return node;
}
 
struct treeNode *createNode(int tag, int childNum, struct treeNode *a[])
{
	struct treeNode *node = (struct treeNode*)malloc(sizeof(struct treeNode));
	node->childNum = childNum;
	node->tag = tag;
	node->value = NULL;
	for (int i = 0; i < node->childNum; i ++)
		(node->child)[i] = a[i];
	return node;
}
 
struct treeNode *createEmpty()
{
	struct treeNode *node=(struct treeNode*)malloc(sizeof(struct Node));
	node->childNum=0;
	node->tag=EPS;
	node->value=NULL;
 
	return node;
}
 
void treePrintLevel(struct treeNode *node, int lvl)
{
	if(node!=NULL)
	{
		for(int i = 0; i < 4*lvl; i ++)
			printf("-");
		
		if(node->value==NULL)
			printf("<%d,->\n", node->tag);
		else 
			printf("<%d,%s>\n", node->tag, node->value);
		
		for (i=0; i<node->childNum; i++) {  
			treePrintLevel((node->child)[i], lvl+1);
		}
	}
}
 
void treePrint(struct Node *node)
{
	treePrintLevel(node, 0);
}