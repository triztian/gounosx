
#ifndef _BRIDGE_H_
#define _BRIDGE_H_

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
	size_t actionsN;
	Action actions[];
} Category;

#endif