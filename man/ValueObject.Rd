% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/base-ValueObject.R
\name{ValueObject}
\alias{ValueObject}
\title{Value Object Pattern}
\usage{
ValueObject(given = NA_character_, family = NA_character_)
}
\arguments{
\item{given}{(\code{character}) A character vector with the given name.}

\item{family}{(\code{character}) A character vector with the family name.}
}
\description{
Model a domain concept using natural lingo of domain experts, such as “Passenger,” “Address,” or “Money.”
}
\examples{
# See more examples at <https://tidylab.github.io/R6P/articles>

# In this example we are appointing elected officials to random ministries, just
# like in real-life.
Person <- ValueObject
Person()

# Create a test for objects of type Person
# * Extract the column names of Person by using its Null Object (returned by Person())
# * Check that the input argument has all the columns that a Person has
is.Person <- function(x) all(colnames(x) \%in\% colnames(Person()))

# A 'Minister' is a 'Person' with a ministry title. The Minister constructor
# requires two inputs:
# 1. (`Person`) Members of parliament
# 2. (`character`) Ministry titles
Minister <- function(member = Person(), title = NA_character_) {
  stopifnot(is.Person(member), is.character(title))
  stopifnot(nrow(member) == length(title) | all(is.na(title)))

  member |> dplyr::mutate(title = title)
}

# Given one or more parliament members
# When appoint_random_ministries is called
# Then the parliament members are appointed to an office.
appoint_random_ministries <- function(member = Person()) {
  positions <- c(
    "Arts, Culture and Heritage", "Finance", "Corrections", "Racing",
    "Sport and Recreation", "Housing", "Energy and Resources", "Education",
    "Public Service", "Disability Issues", "Environment", "Justice",
    "Immigration", "Defence", "Internal Affairs", "Transport"
  )

  Minister(member = member, title = sample(positions, size = nrow(member)))
}

# Listing New Zealand elected officials in 2020, we instantiate a Person object,
# appoint them to random offices, and return a Minister value object.
set.seed(2020)
parliament_members <- Person(
  given = c("Jacinda", "Grant", "Kelvin", "Megan", "Chris", "Carmel"),
  family = c("Ardern", "Robertson", "Davis", "Woods", "Hipkins", "Sepuloni")
)

parliament_members
appoint_random_ministries(member = parliament_members)
}
\seealso{
Other base design patterns: 
\code{\link{NullObject}()},
\code{\link{Singleton}}
}
\concept{base design patterns}
