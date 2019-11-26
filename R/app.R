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

                                        )

                        #shiny::tabPanel("Report")
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

    req(input$data_in, input$lever_choice, input$inst_name)

    if (input$plot == "lever") {

      req(input$aggregate)

      tcps_lever_ridgeline(data(), lever = input$lever_choice, name = input$inst_name, aggregate = as.logical(input$aggregate))

    } else if (input$plot == "scale") {

      req(input$groups)

      tcps_lever_scale(data(), choice = input$lever_choice, name = input$inst_name, group = input$groups)
    }



  })

  output$inst_name <- renderUI({

    shiny::req(input$data_in)

    shiny::textInput(inputId = "inst_name", label = "Enter Institution name")

  })


  output$aggregate <- renderUI({

    shiny::req(input$data_in, input$plot)

    if (input$plot != "scale") {

      shiny::selectInput(inputId = "aggregate", label = "Aggregate Populations?", choices = c("", "Yes" = TRUE, "No" = FALSE))

    }

  })

  output$groups <- renderUI({

    shiny::req(input$data_in, input$plot)

    if (input$plot != "lever") {

      shiny::selectInput(inputId = "groups", label = "Select Population", choices = c("", "Staff" = "staff", "Student" = "student", "Faculty" = "faculty", "All" = "all"))

    }

  })



  output$lever_choice <- renderUI({

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


}


tcps_gui <- function() {
  shiny::shinyApp(ui = ui, server = server)
  }

