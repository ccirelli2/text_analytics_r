'Reference : https://cran.r-project.org/web/packages/quanteda/vignettes/quickstart.html
'

# Import Libraries
library(quanteda)
library(readtext)
library(spacyr)
library(lintr)


# Set Working Directory
wd <- 'C:\\Users\\chris.cirelli\\Desktop\\repositories\\text_analytics_r'
setwd(wd)
list.files()

# Linter
lintr::lint('C:\\Users\\chris.cirelli\\Desktop\\repositories\\text_analytics_r\\quanteda_tutorial.R')


#####################################################################
# Loading Data & Creating Corpus
#####################################################################

# Read In Built In Corpus
corp_uk <- corpus(data_char_ukimmig2010)
summary(corp_uk)

# Reading Text Files In Cwd
'companion package, returns data frame
 Can be used with corpus()
'
ex.text <- readtext('*.txt')

# Create a corpus
'corpus : designed to be a library of original documents that have been converted
          to plain UTF-8 encoded text and stored along with meta-data at the
          corpus level and at the document level.  Intended to be an imutable obj.
          Rather, text can be extracted from the corpus for processing.
 docvars : special name for document-level meta-data.  These are variables or
          features that describe attributes of each document.'
ex.corp <- corpus(ex.text)
corp.summary <- summary(ex.corp)
corp.summary

# Extract Text From Corpus
texts(ex.corp)



#####################################################################
# Tools to handle Corpus Objects
#####################################################################

# Corpus Operations
'
Concatenation : corp1 + corp2
subset : corpus_subset(corpus, Condition)
'

# Key Word Search
kwic(ex.corp, patter="senate")

# Phrases
'Includes the line and context where the phrase was found'
kwic(ex.corp, pattern=phrase("United States")) %>% head()

# Inspect Document Level Variables
head(docvars(ex.corp))


#####################################################################
# Tokenization
#####################################################################
'In order to perform statistical analysis such as document scaling,
 we must extract a matrix associated with values for certain features
 with each document.  In quanteda we use dfm() function which stands
 for document frequency matrix, where by each row represents a document
 and each column a unique token.  Values in the matrix are the frequency
 with which each token appears.
'
# Get list of tokens
txt1 <- 'Today is a good day to code!'
txt2 <- 'Today is a good day to code!  Tomorrow will be as well!'
tkn.txt1 <- tokens(txt1)
tkn.txt1

# Example - tokenize & remove punctuation
tkn.txt1 <- tokens(txt1, remove_punct = TRUE)
tkn.txt1

# Example- Toknize w/ multiple operations
tkn.txt1 <- tokens(txt1, remove_numbers = TRUE,
                   remove_punct = TRUE,
                   remove_symbols = FALSE)
tkn.txt1

# Tokenize at character lvl
tkn.txt1.chars <- tokens(txt1, what="character")

# Tokenize Scentences
tkn.txt2 <- tokens(txt2, what="sentence")



#####################################################################
# Constructing a document feature matrix
#####################################################################

# dfm for a sentence
dfm.txt1 <- dfm(txt1)
dfm.txt1

# dfm for a corpus
dfm.corp1 <- dfm(ex.corp)
dfm.corp1

# Create Dfm & Remove Stop Words
dfm.corp1 <- dfm(ex.corp, remove=stopwords("english"), stem=TRUE, remove_punct=TRUE)
dfm.corp1

# Access List of most frequently occuring features
topfeatures(dfm.corp1)


#####################################################################
# Plotting
#####################################################################
textplot_wordcloud(dfm.corp1, min_count = 6, random_order = FALSE,
                   rotation = 0.25, 
                   color = RColorBrewer::brewer.pal(8, "Dark2"))
