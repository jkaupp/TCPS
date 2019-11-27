ui <- shiny::navbarPage("Teaching Culture Perception Survey", inverse = TRUE, header = shiny::tagList(shiny::includeCSS(here::here("inst", "css", "normalize.css"), shiny::includeCSS(here::here("inst", "css", "skeleton.css")))),
                        shiny::tabPanel("Instructions",

                                        shiny::includeMarkdown(here::here("inst", "markdown", "instructions.md"))
                        ),
                        shiny::tabPanel("Data",
                                        shiny::sidebarPanel(width = 3,
                                          shiny::fileInput("data_in", "Browse to a TCPS Survey File:", accept = ".xlsx", multiple = TRUE)

                                        ),

                                          shiny::mainPanel(DT::DTOutput("tcps_data_tbl"))

                                        ),
                        shiny::tabPanel("Visualize",
                                        shiny::sidebarPanel(width = 3,
                                          shiny::selectInput("plot", label = "Select Visualization", choices = c("", "lever", "scale")),
                                          shiny::uiOutput("inst_name"),
                                          shiny::uiOutput("lever_choice"),
                                          shiny::uiOutput("aggregate"),
                                          shiny::uiOutput("groups")

                                        ),
                                        shiny::mainPanel(shiny::plotOutput("plots", height = "1000px", width = "100%"))

                                        ),

                        shiny::tabPanel("Report",
                                        shiny::sidebarPanel(width = 3,
                                                            shiny::uiOutput("inst_name2"),
                                                            shiny::uiOutput("file_type"),
                                                            shiny::uiOutput("download_report")

                                        ))
)



server <- function(input, output) {

  # Data ingest ----
  data <- shiny::reactive({

    in_file <- input$data_in

    purrr::map2_dfr(in_file$datapath, in_file$name, ~tcps_tidy_excel(.x, .y))

  })

  output$tcps_data_tbl <- DT::renderDT({

    shiny::req(input$data_in)

    data() %>%
      DT::datatable(rownames = FALSE,
                options = list(dom = "ftp",
                               pageLength = 10)
      )
  })


  output$plots <- shiny::renderPlot({

    shiny::req(input$data_in, input$lever_choice, input$inst_name)

    if (input$plot == "lever") {

      shiny::req(input$aggregate)

      tcps_lever_ridgeline(data(), lever = input$lever_choice, name = input$inst_name, aggregate = as.logical(input$aggregate))

    } else if (input$plot == "scale") {

      shiny::req(input$groups)

      tcps_lever_scale(data(), choice = input$lever_choice, name = input$inst_name, group = input$groups)
    }



  })

  output$inst_name <- shiny::renderUI({

    shiny::req(input$data_in)

    shiny::textInput(inputId = "inst_name", label = "Enter Institution name")

  })

  output$inst_name2 <- shiny::renderUI({

    shiny::req(input$data_in)

    shiny::textInput(inputId = "inst_name2", label = "Enter Institution name")

  })


  output$aggregate <- shiny::renderUI({

    shiny::req(input$data_in, input$plot)

    if (input$plot != "scale") {

      shiny::selectInput(inputId = "aggregate", label = "Aggregate Populations?", choices = c("", "Yes" = TRUE, "No" = FALSE))

    }

  })

  output$groups <- shiny::renderUI({

    shiny::req(input$data_in, input$plot)

    if (input$plot != "lever") {

      shiny::selectInput(inputId = "groups", label = "Select Population", choices = c("", "Staff" = "staff", "Student" = "student", "Faculty" = "faculty", "All" = "all"))

    }

  })

  output$file_type <- shiny::renderUI({

    shiny::req(input$data_in)

      shiny::selectInput(inputId = "file_ext", label = "Select output type", choices = c("", "pdf", "html", "docx"))

  })



  output$lever_choice <- shiny::renderUI({

    shiny::req(input$data_in)

    lever_choices <- c("",
                       "lever 1" = "lever1",
                       "lever 2" = "lever2",
                       "lever 3" = "lever3",
                       "lever 4" = "lever4",
                       "lever 5" = "lever5",
                       "lever 6" = "lever6",
                       "All Levers" = "all")

    if (input$plot == "scale") {

      lever_choices <- lever_choices[1:7]

    }

    shiny::selectInput(inputId = "lever_choice", label = "Select lever", choices = lever_choices)

  })


  output$download_report <- shiny::renderUI({
    shiny::req(input$data_in, input$inst_name2, input$file_ext)
    shiny::downloadButton("report", "Download TCPS Report")
  })

  output$report <- shiny::downloadHandler(

    filename <- sprintf("TCPS Lever Report %s.%s", input$inst_name2, input$file_ext),

    content <- function(file) {

      template <- file.path("inst/templates/shiny_tcps_report_template.Rmd")

      parameters <- list(name = input$inst_name2)

      format <- switch(input$file_ext,
                       html = rmarkdown::html_document(),
                       word = rmarkdown::word_document(),
                       pdf = rmarkdown::pdf_document())

      # Use rmarkdown::render to produce a pdf report
      rmarkdown::render(input = template,
                        output_format = format,
                        output_file = file,
                        params = parameters,
                        clean = TRUE)

    }
  )

}


#' Run the TCPS GUI to read, visualize and report on the data
#'
#' @export
tcps_gui <- function() {
  shiny::shinyApp(ui = ui, server = server)
  }

