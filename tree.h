#ifndef MYTREE
#define MYTREE
#include<string.h>
#include<stdlib.h>
#include<stdio.h>

struct treeNode
{
	char *value;
	int childNum;
	struct treeNode *child[10];
};

struct treeNode *createLeaf(char *text);
struct treeNode *createNode(int childNum, struct treeNode *a[], char *value, int lineno);
struct treeNode *createEmpty();
void treePrintLevel(struct treeNode *node, int lvl);
void treePrint(struct treeNode *node);

struct treeNode *createLeaf(char *text)
{
	struct treeNode *node = (struct treeNode*)malloc(sizeof(struct treeNode));
	node->childNum = 0;
	if (text != NULL)
	{
		node->value=(char*)malloc(sizeof(char)*strlen(text));
		strcpy(node->value, text);
	}
	else
	{
		node->value = NULL;
	}
	return node;
}
 
struct treeNode *createNode(int childNum, struct treeNode *a[], char *value, int lineno)
{
	struct treeNode *node = (struct treeNode*)malloc(sizeof(struct treeNode));
	node->childNum = childNum;
	node->value=(char*)malloc(sizeof(char)*(strlen(value)+12));
	memset(node->value, 0, sizeof(char)*(strlen(value)+12));
	sprintf(node->value, "%s (%d)", value, lineno);
	for (int i = 0; i < node->childNum; i ++)
		(node->child)[i] = a[i];
	return node;
}
 
struct treeNode *createEmpty()
{
	struct treeNode *node=(struct treeNode*)malloc(sizeof(struct treeNode));
	node->childNum=0;
	node->value=NULL;
	return node;
}
 
void treePrintLevel(struct treeNode *node, int depth)
{
	if (node == NULL 
		|| node->value==NULL 
		|| (node->childNum == 1 && (node->child)[0]->value==NULL)) return;
	
	for (int i = 0; i < 2*depth; i ++) printf(" ");
	printf("%s\n", node->value, node->childNum);
	for (int i = 0; i < node->childNum; i ++)   
		treePrintLevel((node->child)[i], depth+1);
}
 
void treePrint(struct treeNode *node)
{
	treePrintLevel(node, 0);
}
#endif