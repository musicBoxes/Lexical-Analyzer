#include "tree.h"

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
 
struct treeNode *createNode(int childNum, struct treeNode *a[])
{
	struct treeNode *node = (struct treeNode*)malloc(sizeof(struct treeNode));
	node->childNum = childNum;
	node->value = NULL;
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
 
void treePrintLevel(struct treeNode *node, int lvl)
{
	if(node!=NULL)
	{
		for(int i = 0; i < 4*lvl; i ++)
			printf("-");
		
		if(node->value==NULL)
		{
			
		}
		else 
		{
			printf("%s\n", node->value);
		}
		for (i=0; i<node->childNum; i++) {  
			treePrintLevel((node->child)[i], lvl+1);
		}
	}
}
 
void treePrint(struct Node *node)
{
	treePrintLevel(node, 0);
}