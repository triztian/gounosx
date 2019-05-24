
#ifndef _BRIDGE_H_
#define _BRIDGE_H_

#include "stdlib.h"

typedef struct {
	char *id;
	char *title;
	size_t optionsN;
	int options[];
} Action;

typedef struct {
	char *id;
	char *hiddenPreviewsBodyPlaceholder;
	int options;
	Action *actions;
	size_t actionsN;
} Category;

#endif