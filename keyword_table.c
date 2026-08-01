#include <string.h>
#include <strings.h>

#include "keyword_table.h"
#include "parser.tab.h"

typedef struct
{
    const char *word;
    int token;

} KeywordEntry;


/*=====================================================
    Karayel Reserved Keywords
=====================================================*/

static KeywordEntry keywordTable[] =
{
    {"KL",      KL},
    {"Show",    SHOW},
    {"Scan",    SCAN},
    {"Task",    TASK},
    {"Give",    GIVE},

    {"If",      IF},
    {"Elif",    ELIF},
    {"Else",    ELSE},

    {"While",   WHILE},
    {"For",     FOR},

    {"True",    TRUE},
    {"False",   FALSE}
};


/*=====================================================
    Keyword Lookup
=====================================================*/

int checkKeyword(const char *text)
{
    int totalKeywords =
        sizeof(keywordTable) / sizeof(keywordTable[0]);

    for (int i = 0; i < totalKeywords; i++)
    {
        if (strcasecmp(text, keywordTable[i].word) == 0)
        {
            return keywordTable[i].token;
        }
    }

    return IDENTIFIER;
}